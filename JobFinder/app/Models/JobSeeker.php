<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JobSeeker extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    protected $fillable = [
        'user_id',
        'specialization_id',
        'full_name',
        'address',
        'phone',
        'age',
        'languages',
        'gpa',
        'experience_years',
    ];

    protected $casts = [
        'languages' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }

    public function skills()
    {
        return $this->belongsToMany(Skill::class, 'job_seeker_skill');
    }

    public function jobApplications()
    {
        return $this->hasMany(JobApplication::class);
    }
}
