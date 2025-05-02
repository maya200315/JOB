// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Controller/ServicesProvider.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/View/Admin/Home/Controller/HomePageAdminController.dart';
import 'package:job_finder_app/View/Admin/Home/HomePageAdmin.dart';
import 'package:job_finder_app/View/Auth/SignUp/Controller/SignupController.dart';
import 'package:job_finder_app/View/Auth/SignUp/Signup.dart';
import 'package:job_finder_app/View/Employer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:job_finder_app/View/Employer/Navigation/NavigationPageEmployeer.dart';
import 'package:job_finder_app/View/JobSeeker/Navigation/Controller/NavigationPageJobSeekerController.dart';
import 'package:job_finder_app/View/JobSeeker/Navigation/NavigationPageJobSeeker.dart';
import 'package:provider/provider.dart';

class LoginController with ChangeNotifier {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    usernamecontroller.clear();
    passwordcontroller.clear();
    log("close login");
    super.dispose();
  }

  static NetworkClient client = NetworkClient(http.Client());
  Future<Either<Failure, bool>> Login(BuildContext context) async {
    log(usernamecontroller.text);
    log(passwordcontroller.text);
    try {
      final response = await client.request(
        path: AppApi.LOGIN,
        requestType: RequestType.POST,
        body: jsonEncode({
          "user_name": usernamecontroller.text,
          "password": passwordcontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        ServicesProvider.saveTokenAndRole(
          data['data']['token'],
          data['data']['role'],
        );
        if (data['data']['role'] == 'admin') {
          CustomDialog.DialogSuccess(
            context,
            title: "Login to dashboard successful",
          );
          CustomRoute.RouteReplacementTo(
            context,
            ChangeNotifierProvider(
              builder: (context, child) => HomePageAdmin(),
              create:
                  (context) =>
                      HomePageAdminController()
                        ..GetAllCompanyPending(context)
                        ..GetAllSkills(context)
                        ..GetAllSpecializations(context),
            ),
          );
        } else if (data['data']['role'] == 'employer') {
          CustomDialog.DialogSuccess(context, title: "Login successful");
          CustomRoute.RouteReplacementTo(
            context,
            ChangeNotifierProvider(
              builder: (context, child) => NavigationPageEmployeer(),
              create: (context) => NavigationPageEmployeerController(),
            ),
          );
        } else if (data['data']['role'] == 'center') {
          CustomDialog.DialogSuccess(context, title: "Login successful");
        } else if (data['data']['role'] == 'job_seeker') {
          CustomDialog.DialogSuccess(context, title: "Login successful");
          CustomRoute.RouteReplacementTo(
            context,
            ChangeNotifierProvider(
              builder: (context, child) => NavigationPageJobSeeker(),
              create: (context) => NavigationPageJobSeekerController(),
            ),
          );
        }
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

  toSignUpPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        create:
            (context) =>
                SignupController()
                  ..GetAllSkills(context)
                  ..GetAllSpecializations(context),
        lazy: true,
        builder: (context, child) => Signup(),
      ),
    );
  }
}
