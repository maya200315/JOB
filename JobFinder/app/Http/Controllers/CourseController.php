<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Course;
use App\Traits\ApiResponseTrait;

class CourseController extends Controller
{
    use ApiResponseTrait;

    public function myCourses(Request $request)
    {
        $centerId = $request->user()->center->id;

        $courses = Course::where('center_id', $centerId)->get();

        return $this->SuccessResponse($courses, 'My courses retrieved successfully');
    }

    public function allCourses()
    {
        $courses = Course::with('center')->get();

        return $this->SuccessResponse($courses, 'All courses retrieved successfully');
    }


    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
            'duration_in_hours' => 'nullable|integer',
        ]);

        $course = Course::create([
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
            'start_date' => $validated['start_date'] ?? null,
            'end_date' => $validated['end_date'] ?? null,
            'duration_in_hours' => $validated['duration_in_hours'] ?? null,
            'center_id' => $request->user()->center->id,
        ]);

        return $this->SuccessResponse($course,'Course created successfully',201);
    }

    public function update(Request $request, $id)
    {
        $course = Course::findOrFail($id);

        if ($course->center_id !== $request->user()->center->id) {
            return  $this->ErrorResponse('Unauthorized', 403);
        }

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
            'duration_in_hours' => 'nullable|integer',
        ]);

        $course->update($validated);

        return  $this->SuccessResponse($course,'Course updated successfully');
    }

    public function destroy(Request $request, $id)
    {
        $course = Course::findOrFail($id);

        if ($course->center_id !== $request->user()->center->id) {
            return  $this->ErrorResponse('Unauthorized', 403);

        }

        $course->delete();
        return  $this->SuccessResponse('','Course deleted successfully');
    }
}
