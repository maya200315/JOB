<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Skill extends Model
{
    use HasFactory;

    protected $fillable = ['name'];
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    public function jobSeekers()
    {
        return $this->belongsToMany(JobSeeker::class, 'job_seeker_skill')
                    ->withPivot('rating')
                    ->withTimestamps();
    }
}
