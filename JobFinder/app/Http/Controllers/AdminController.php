<?php

namespace App\Http\Controllers;

use App\Models\Specialization;
use App\Models\Skill;
use App\Models\Employer;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    use ApiResponseTrait;
    public function getSpecializations()
    {
        return $this->SuccessResponse(Specialization::all(),'Retrive all specializations');
    }

    public function addSpecialization(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:specializations,name'
        ]);
        $spec = Specialization::create([
            'name' => $request->name
        ]);
        return $this->SuccessResponse($spec,'Create Specialization Successfuly', 201);
    }

    public function deleteSpecialization($id)
    {
        $spec = Specialization::findOrFail($id);
        $spec->delete();
        return $this->SuccessResponse('','Specialization deleted Successfuly');
    }

    public function getSkills()
    {
        return $this->SuccessResponse(Skill::all(),'Retrive all Skills');
    }

    public function addSkill(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:skills,name'
        ]);
        $skill = Skill::create([
            'name' => $request->name
        ]);
        return $this->SuccessResponse($skill,'Create Skill Successfuly', 201);
    }

    public function deleteSkill($id)
    {
        $skill = Skill::findOrFail($id);
        $skill->delete();
        return $this->SuccessResponse('','Skill deleted Successfuly');
    }

    public function pendingEmployers()
    {
        $pending = Employer::where('is_verified', null)->with('user','specialization')->get();
        return $this->SuccessResponse($pending,'Retrive all company pending');
    }

    public function approveEmployer($id)
    {
        $employer = Employer::findOrFail($id);
        $employer->is_verified = true;
        $employer->save();
        return $this->SuccessResponse('','Employer approved');
    }

    public function rejectEmployer($id)
    {
        $employer = Employer::findOrFail($id);
        $employer->is_verified = false;
        $employer->save();
        return $this->SuccessResponse('','Employer rejected');
    }
}
