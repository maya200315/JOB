<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    protected $fillable = [
        'center_id',
        'title',
        'description',
        'instructor_name',
        'start_date',
        'end_date',
        'duration_in_hours',
        'course_image',
    ];

    public function center()
    {
        return $this->belongsTo(Center::class);
    }
}
