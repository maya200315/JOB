import 'package:flutter/material.dart';
import 'package:job_finder_app/View/Employer/Home/Controller/HomePageEmployerController.dart';
import 'package:job_finder_app/View/Employer/Home/HomePAgeEmployer.dart';
import 'package:job_finder_app/View/Employer/MyJobs/Controller/MyJobsPageController.dart';
import 'package:job_finder_app/View/Employer/MyJobs/MyJobsPage.dart';
import 'package:job_finder_app/View/Employer/Settings/Controller/SettingsPageController.dart';
import 'package:job_finder_app/View/Employer/Settings/SettingsPageEmployer.dart';
import 'package:provider/provider.dart';

class NavigationPageEmployeerController with ChangeNotifier {
  int index = 1;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create:
          (context) =>
              MyJobsPageController()
                ..GetAllSpecializations(context)
                ..GetAllMyJobs(context),
      builder: (context, child) => MyJobsPage(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomePageEmployerController(),
      builder: (context, child) => HomePageEmployer(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsPageEmployerController(),
      builder: (context, child) => SettingsPageEmployer(),
    ),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
