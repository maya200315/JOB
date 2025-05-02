<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Auth;


class RoleMiddleware
{
    use ApiResponseTrait;
    public function handle(Request $request, Closure $next, $role)
    {
        $user = $request->user();

        if (!$user || $user->role !== $role) {
            return $this->ErrorResponse('Unauthorized Access', 403);
        }

        return $next($request);
    }
}
