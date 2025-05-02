<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Specialization extends Model
{
    use HasFactory;

    protected $fillable = ['name'];
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function employers()
    {
        return $this->hasMany(Employer::class);
    }

    public function jobSeekers()
    {
        return $this->hasMany(JobSeeker::class);
    }
}

