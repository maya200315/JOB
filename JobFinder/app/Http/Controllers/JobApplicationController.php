<?php

namespace App\Http\Controllers;

use App\Models\Job;
use App\Models\JobApplication;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;
use Carbon\Carbon;

class JobApplicationController extends Controller
{
    use ApiResponseTrait;

    public function apply(Request $request, $jobId)
    {
        $user = $request->user();

        $job = Job::findOrFail($jobId);

        if ($job->deadline && Carbon::now()->gt(Carbon::parse($job->deadline))) {
            return $this->ErrorResponse('Deadline has passed. You cannot apply for this job.', 400);
        }

        $existingApplication = JobApplication::where('job_id', $job->id)
            ->where('job_seeker_id', $user->jobSeeker->id)
            ->first();

        if ($existingApplication) {
            return $this->ErrorResponse('You have already applied to this job.', 400);
        }

        $application = JobApplication::create([
            'job_id' => $job->id,
            'job_seeker_id' => $user->jobSeeker->id,
            'status' => 'pending',
        ]);

        return $this->SuccessResponse($application, 'Applied successfully to the job.');
    }

    public function withdraw(Request $request, $jobId)
    {
        $user = $request->user();

        $application = JobApplication::where('job_id', $jobId)
            ->where('job_seeker_id', $user->jobSeeker->id)
            ->first();

        if (!$application) {
            return $this->ErrorResponse('No application found for this job.', 404);
        }

        $application->delete();

        return $this->SuccessResponse('', 'Application withdrawn successfully.');
    }

    public function myApplications(Request $request)
    {
        $user = $request->user();

        $applications = JobApplication::where('job_seeker_id', $user->jobSeeker->id)
            ->with('job.employer:id,company_name,company_phone,company_address,company_logo','job.specialization')
            ->latest()
            ->get();

        return $this->SuccessResponse($applications, 'Your job applications retrieved successfully.');
    }

    public function jobApplicants(Request $request, $jobId)
    {
        $user = $request->user();

        $job = Job::where('id', $jobId)
            ->where('employer_id', $user->employer->id)
            ->first();

        if (!$job) {
            return $this->ErrorResponse('Unauthorized or job not found.', 403);
        }

        $applications = JobApplication::where('job_id', $jobId)
            ->with([
                'jobSeeker.specialization:id,name',
                'jobSeeker.skills:id,name',
            ])
            ->latest()
            ->get()
            ->map(function ($application) {
                $jobSeeker = $application->jobSeeker;

                return [
                    'application_id' => $application->id,
                    'status' => $application->status,
                    'applied_at' => $application->created_at,
                    'job_seeker' => [
                        'id' => $jobSeeker->id,
                        'full_name' => $jobSeeker->full_name,
                        'address' => $jobSeeker->address,
                        'phone' => $jobSeeker->phone,
                        'age' => $jobSeeker->age,
                        'languages' => $jobSeeker->languages,
                        'gpa' => $jobSeeker->gpa,
                        'experience_years' => $jobSeeker->experience_years,
                        'specialization' => $jobSeeker->specialization->name ?? null,
                        'skills' => $jobSeeker->skills->pluck('name'),
                    ],
                ];
            });

        return $this->SuccessResponse($applications, 'Job applicants retrieved successfully.');
    }

    public function respondToApplication(Request $request, $applicationId, $status)
    {
        $user = $request->user();

        $application = JobApplication::where('id', $applicationId)
            ->whereHas('job', function ($query) use ($user) {
                $query->where('employer_id', $user->employer->id);
            })
            ->with('jobSeeker.user')
            ->first();

        if (!$application) {
            return $this->ErrorResponse('Unauthorized or application not found.', 403);
        }

        if (!in_array($status, ['accepted', 'rejected'])) {
            return $this->ErrorResponse('Invalid status.', 422);
        }

        $application->status = $status;
        $application->save();

        $notificationMessage = $status === 'accepted'
            ? "Congratulations! Your application in {$user->employer->company_name} has been accepted."
            : "Sorry, your application in {$user->employer->company_name} has been rejected.";


        Notification::create([
            'user_id' => $application->jobSeeker->user->id,
            'title' => 'Job Application Update',
            'message' => $notificationMessage,
        ]);

        return $this->SuccessResponse($application, 'Application status updated successfully.');
    }

}
