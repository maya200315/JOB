// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:job_finder_app/Controller/ServicesProvider.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/View/Admin/Home/Controller/HomePageAdminController.dart';
import 'package:job_finder_app/View/Admin/Home/HomePageAdmin.dart';
import 'package:job_finder_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:job_finder_app/View/Auth/Login/Login.dart';
import 'package:job_finder_app/View/Employer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:job_finder_app/View/Employer/Navigation/NavigationPageEmployeer.dart';
import 'package:job_finder_app/View/JobSeeker/Navigation/Controller/NavigationPageJobSeekerController.dart';
import 'package:job_finder_app/View/JobSeeker/Navigation/NavigationPageJobSeeker.dart';
import 'package:provider/provider.dart';

class SplashController with ChangeNotifier {
  @override
  dispose() {
    log("close splash");
    super.dispose();
  }

  whenIslogin(BuildContext context) async {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      if (await ServicesProvider.isLoggin()) {
        switch (ServicesProvider.getRole()) {
          case 'admin':
            toDashboardPage(context);
            break;
          case 'employer':
            toEmployerPage(context);
            break;
          case 'job_seeker':
            toJobSeekerPage(context);
            break;
          default:
            toLoginPage(context);
        }
      } else {
        toLoginPage(context);
      }
    });
  }

  toLoginPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider<LoginController>(
        create: (context) => LoginController(),
        child: Login(),
      ),
    );
  }

  toDashboardPage(BuildContext context) {
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
  }

  toEmployerPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        builder: (context, child) => NavigationPageEmployeer(),
        create: (context) => NavigationPageEmployeerController(),
      ),
    );
  }

  toJobSeekerPage(BuildContext context) {
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider(
        builder: (context, child) => NavigationPageJobSeeker(),
        create: (context) => NavigationPageJobSeekerController(),
      ),
    );
  }
}
