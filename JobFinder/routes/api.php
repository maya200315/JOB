<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\JobApplicationController;
use App\Http\Controllers\JobController;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\NotificationController;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\RoleMiddleware;
use App\Http\Middleware\VerifiedEmployerMiddleware;


Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::get('/specializations', [AdminController::class, 'getSpecializations']);
Route::get('/skills', [AdminController::class, 'getSkills']);
Route::middleware('auth:sanctum')->group(function () {

    Route::get('/courses', [CourseController::class, 'allCourses']);
    Route::get('/jobs', [JobController::class, 'getAllJobs']);
    Route::get('/notifications', [NotificationController::class, 'getNotifications']);

    Route::middleware([RoleMiddleware::class.':employer',VerifiedEmployerMiddleware::class])->group(function () {
        Route::get('/my-jobs', [JobController::class, 'getEmployerJobs']);
        Route::post('/jobs', [JobController::class, 'store']);
        Route::put('/jobs/{id}', [JobController::class, 'update']);
        Route::delete('/jobs/{id}', [JobController::class, 'destroy']);
        Route::get('/jobs/{jobId}/applicants', [JobApplicationController::class, 'jobApplicants']);
        Route::put('/applications/{applicationId}/respond/{status}', [JobApplicationController::class, 'respondToApplication']);
    });

    Route::middleware(RoleMiddleware::class.':job_seeker')->group(function () {
        Route::get('/opportunities', [JobSeekerController::class, 'getRelevantOpportunities']);
        Route::post('/jobs/{jobId}/apply', [JobApplicationController::class, 'apply']);
        Route::delete('/jobs/{jobId}/withdraw', [JobApplicationController::class, 'withdraw']);
        Route::get('/my-applications', [JobApplicationController::class, 'myApplications']);
    });

    Route::middleware(RoleMiddleware::class.':center')->group(function () {
        Route::get('/my-courses', [CourseController::class, 'myCourses']);
        Route::post('/courses', [CourseController::class, 'store']);
        Route::put('/courses/{id}', [CourseController::class, 'update']);
        Route::delete('/courses/{id}', [CourseController::class, 'destroy']);

    });

    Route::middleware(RoleMiddleware::class.':admin')->group(function () {
        Route::post('/specializations', [AdminController::class, 'addSpecialization']);
        Route::delete('/specializations/{id}', [AdminController::class, 'deleteSpecialization']);
        Route::post('/skills', [AdminController::class, 'addSkill']);
        Route::delete('/skills/{id}', [AdminController::class, 'deleteSkill']);
        Route::get('/pending-employers', [AdminController::class, 'pendingEmployers']);
        Route::post('/approve-employer/{id}', [AdminController::class, 'approveEmployer']);
        Route::post('/reject-employer/{id}', [AdminController::class, 'rejectEmployer']);
    });

});


