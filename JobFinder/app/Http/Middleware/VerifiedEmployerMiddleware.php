<?php

namespace App\Http\Middleware;

use App\Traits\ApiResponseTrait;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class VerifiedEmployerMiddleware
{
    use ApiResponseTrait;
    public function handle(Request $request, Closure $next): Response
    {
        $employer = $request->user()->employer;

        if (!$employer || !$employer->is_verified) {
            return $this->ErrorResponse('Your account is not verified to perform this action.', 403);
        }

        return $next($request);
    }
}
