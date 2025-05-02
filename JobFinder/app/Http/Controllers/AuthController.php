<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegisterRequest;
use App\Models\User;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    use ApiResponseTrait;
    public function register(RegisterRequest $request)
    {
        $user = User::create([
            'user_name' => $request->user_name,
            'password' => bcrypt($request->password),
            'role' => $request->role,
        ]);

        match ($request->role) {
            'employer' => $user->employer()->create([
                'company_name' => $request->company_name,
                'company_phone' => $request->company_phone,
                'company_address' => $request->company_address,
                'specialization_id' => $request->specialization_id,
                'company_logo' => $request->hasFile('company_logo')
                    ? $request->file('company_logo')->store('companies', 'public')
                    : null,
            ]),

            'center' => $user->center()->create([
                'center_name' => $request->center_name,
                'center_address' => $request->center_address,
            ]),

            'job_seeker' => $user->jobSeeker()->create([
                'specialization_id' => $request->specialization_id,
                'full_name' => $request->full_name,
                'address' => $request->address,
                'phone' => $request->phone,
                'age' => $request->age,
                'languages' => $request->languages,
                'gpa' => $request->gpa,
                'experience_years' => $request->experience_years,
            ]),

            default => null
        };

        if ($request->role == 'job_seeker' && $request->filled('skills')) {
            foreach ($request->skills as $skill) {
                $user->jobSeeker->skills()->attach($skill);
            }
        }

        return $this->SuccessResponse($user, 'Account created successfully', 201);
    }


        public function login(Request $request)
        {
            $request->validate([
                'user_name' => 'required|string',
                'password' => 'required|string',
            ]);

            $user = User::where('user_name', $request->user_name)->first();

            if (!$user) {
                return $this->ErrorResponse('User not found', 404);
            }

            if (!Hash::check($request->password, $user->password)) {
                return $this->ErrorResponse('Invalid credentials', 401);
            }

            $token = $user->createToken('jobfinder')->plainTextToken;

            return $this->SuccessResponse([
                'token' => $token,
                'role' => $user->role,
            ], 'Login successful', 200);
        }
}


