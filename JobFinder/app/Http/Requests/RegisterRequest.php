<?php
namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $base = [
            'user_name' => 'required|string|unique:users',
            'password' => 'required|string|min:6',
            'role' => 'required|in:admin,job_seeker,employer,center',
        ];

        return match ($this->role) {
            'employer' => array_merge($base, [
                'company_name' => 'required|string',
                'company_phone' => 'required|string',
                'company_address' => 'required|string',
                'specialization_id' => 'required|exists:specializations,id',
                'company_logo' => 'nullable|image|mimes:jpg,jpeg,png,webp',
            ]),
            'center' => array_merge($base, [
                'center_name' => 'required|string',
                'center_address' => 'required|string',
            ]),
            'job_seeker' => array_merge($base, [
                'specialization_id' => 'required|exists:specializations,id',
                'full_name' => 'required|string',
                'address' => 'required|string',
                'phone' => 'required|string',
                'age' => 'required|integer|min:18|max:99',
                'languages' => 'required|array',
                'gpa' => 'nullable|numeric|min:0|max:4',
                'experience_years' => 'nullable|integer|min:0',
            ]),
            default => $base
        };
    }
}
