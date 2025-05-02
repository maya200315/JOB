<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Notification;
use App\Traits\ApiResponseTrait;

class NotificationController extends Controller
{
    use ApiResponseTrait;
    public function getNotifications(Request $request)
    {
        $user = $request->user();

        $notifications = Notification::where('user_id', $user->id)
            ->latest()
            ->get();

        if ($notifications->isEmpty()) {
            return $this->ErrorResponse('No notifications found', 404);
        }

        return $this->SuccessResponse($notifications, 'Notifications retrieved successfully');
    }
}
