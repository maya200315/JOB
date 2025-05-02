<?php

namespace App\Traits;

trait ApiResponseTrait
{
    public function SuccessResponse($data=null,$message=null,$code=200)
    {
        // إرجاع استجابة JSON تحتوي على البيانات والرسالة وكود الاستجابة
        $array=[
            'data'=>$data,
            'message'=>$message,
            'code'=>$code
        ];
        return response($array,$code);
    }

    public function ErrorResponse($message=null,$code=400)
    {
        // إرجاع استجابة JSON تحتوي على رسالة الخطأ وكود الاستجابة
        $array=[
            'message'=>$message,
            'code'=>$code
        ];
        return response($array,$code);
    }
}

