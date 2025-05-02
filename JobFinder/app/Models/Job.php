<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    protected $fillable = [
        'employer_id',
        'title',
        'description',
        'location',
        'salary',
        'specialization_id',
        'deadline',
    ];

    public function employer()
    {
        return $this->belongsTo(Employer::class, 'employer_id');
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }

    public function applications()
    {
        return $this->hasMany(JobApplication::class);
    }
}
