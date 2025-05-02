<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $timestamps = false;

    protected $fillable = [
        'user_name',
        'password',
        'role',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
        'password',

    ];


    public function employer()
    {
        return $this->hasOne(Employer::class);
    }

    public function center()
    {
        return $this->hasOne(Center::class);
    }

    public function jobSeeker()
    {
        return $this->hasOne(JobSeeker::class);
    }

    public function rating()
    {
        return $this->hasOne(Rating::class);
    }

    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }

}
