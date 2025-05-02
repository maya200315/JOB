<?php
namespace App\Http\Controllers;

use App\Models\Job;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

class JobController extends Controller
{
    use ApiResponseTrait;

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'location' => 'nullable|string',
            'salary' => 'nullable|integer',
            'specialization_id' => 'nullable|exists:specializations,id',
            'deadline' => 'nullable|date',
        ]);

        $job = Job::create([
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
            'location' => $validated['location'] ?? null,
            'salary' => $validated['salary'] ?? null,
            'specialization_id' => $validated['specialization_id'] ?? null,
            'deadline' => $validated['deadline'] ?? null,
            'employer_id' => $request->user()->employer->id,
        ]);

        return $this->SuccessResponse($job, 'Job created successfully', 201);
    }

    public function update(Request $request, $id)
    {
        $job = Job::findOrFail($id);

        if ($job->employer_id !== $request->user()->employer->id) {
            return $this->ErrorResponse('Unauthorized', 403);
        }

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'location' => 'nullable|string',
            'salary' => 'nullable|integer',
            'specialization_id' => 'nullable|exists:specializations,id',
            'deadline' => 'nullable|date',
        ]);

        $job->update($validated);

        return $this->SuccessResponse($job, 'Job updated successfully');
    }

    public function destroy(Request $request, $id)
    {
        $job = Job::findOrFail($id);

        if ($job->employer_id !== $request->user()->employer->id) {
            return $this->ErrorResponse('Unauthorized', 403);
        }

        $job->delete();

        return $this->SuccessResponse('', 'Job deleted successfully');
    }

    public function getEmployerJobs(Request $request)
    {
        $jobs = Job::where('employer_id', $request->user()->employer->id)
                    ->with('specialization')->get();

        return $this->SuccessResponse($jobs, 'Employer jobs retrieved successfully');
    }

    public function getAllJobs()
    {
        $jobs = Job::with('employer')->get();

        return $this->SuccessResponse($jobs, 'All jobs retrieved successfully');
    }


}
