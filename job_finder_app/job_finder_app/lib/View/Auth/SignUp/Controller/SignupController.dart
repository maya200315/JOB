// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Model/Skill.dart';
import 'package:job_finder_app/Model/Specialization.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:job_finder_app/View/Auth/Login/Login.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignupController with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedRole = 'job_seeker'; // default role

  int? specializationId;
  List<int?> selectedskills_ids = [];

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gpaController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();
  List<String> selectedlanguages = [];
  List<Skill> skills = [];
  List<Specialization> specializations = [];

  TextEditingController centerNameController = TextEditingController();
  TextEditingController centerAddressController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();

  ImagePicker picker = ImagePicker();
  XFile? image;
  PickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  RemoveImage() async {
    image = null;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    centerNameController.dispose();
    centerAddressController.dispose();
    companyNameController.dispose();
    companyPhoneController.dispose();
    companyAddressController.dispose();
    log("close signup");
    super.dispose();
  }

  static NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> signup(BuildContext context) async {
    try {
      http.MultipartFile? file;
      Map<String, String> body = {
        "user_name": usernameController.text,
        "password": passwordController.text,
        "role": selectedRole,
      };

      if (selectedRole == 'job_seeker') {
        body.addAll({
          "specialization_id": specializationId.toString(),
          "full_name": fullNameController.text,
          "address": addressController.text,
          "phone": phoneController.text,
          "age": ageController.text,
          "languages": selectedlanguages.toString(),
          "gpa": gpaController.text,
          "experience_years": experienceYearsController.text,
          "skills": selectedskills_ids.toString(),
        });
      } else if (selectedRole == 'center') {
        body.addAll({
          "center_name": centerNameController.text,
          "center_address": centerAddressController.text,
        });
      } else if (selectedRole == 'employer') {
        body.addAll({
          "company_name": companyNameController.text,
          "company_phone": companyPhoneController.text,
          "company_address": companyAddressController.text,
          "specialization_id": specializationId.toString(),
        });
        if (image != null) {
          file = await http.MultipartFile.fromPath('company_logo', image!.path);
        }
      }
      var response;
      if (image != null) {
        response = await client.requestwithfile(
          path: AppApi.REGISTER,
          body: body,
          file: file!,
        );
      } else {
        response = await client.request(
          path: AppApi.REGISTER,
          requestType: RequestType.POST,
          body: jsonEncode(body),
        );
      }

      log(response.statusCode.toString());
      // log(response.body);

      if (response.statusCode == 201) {
        CustomRoute.RouteReplacementTo(
          context,
          ChangeNotifierProvider(
            create: (context) => LoginController(),
            lazy: true,
            builder: (context, child) => Login(),
          ),
        );
        CustomDialog.DialogSuccess(
          context,
          title: "Create account was successfully",
        );
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(''));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      return Left(GlobalFailure());
    }
  }

  void toLoginPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create: (context) => LoginController(),
        lazy: true,
        builder: (context, child) => Login(),
      ),
    );
  }

  void setRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  void setSpecialization(int SpecializationId) {
    specializationId = SpecializationId;
    notifyListeners();
  }

  void setSkills(List<int?> skill_ids) {
    selectedskills_ids = skill_ids;
    notifyListeners();
  }

  void setLanguages(List<String> languages) {
    selectedlanguages = languages;
    notifyListeners();
  }

  Future<Either<Failure, bool>> GetAllSpecializations(
    BuildContext context,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.GetAllSpecializations,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          specializations.add(Specialization.fromJson(element));
        }
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> GetAllSkills(BuildContext context) async {
    try {
      final response = await client.request(
        path: AppApi.GetAllSkills,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          skills.add(Skill.fromJson(element));
        }
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
