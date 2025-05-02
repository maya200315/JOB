<?php

namespace App\Http\Controllers;

use App\Models\Job;
use App\Models\Course;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

class JobSeekerController extends Controller
{
    use ApiResponseTrait;

    public function getRelevantOpportunities(Request $request)
    {
        $user = $request->user();

        $jobSeeker = $user->jobSeeker;

        if (!$jobSeeker || !$jobSeeker->specialization_id) {
            return $this->ErrorResponse('No specialization found for the job seeker.', 400);
        }

        $jobs = Job::where('specialization_id', $jobSeeker->specialization_id)
                    ->with('employer','specialization')
                    ->get();

        if ($jobs->isNotEmpty()) {
            return $this->SuccessResponse($jobs, 'Jobs fetched successfully');
        }

        $courses = Course::with('center')->get();

        return $this->SuccessResponse($courses, 'No jobs found for your specialization. Showing available courses instead.',202);
    }
}
