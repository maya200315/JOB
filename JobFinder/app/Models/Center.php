<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Center extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $hidden = [
        'created_at',
        'updated_at',
    ];
    protected $fillable = [
        'user_id',
        'center_name',
        'center_address',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function courses()
    {
        return $this->hasMany(Course::class);
    }

}
