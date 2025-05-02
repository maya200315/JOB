import 'package:flutter/material.dart';
import 'package:job_finder_app/View/JobSeeker/Home/Controller/HomePageJobSeekerController.dart';
import 'package:job_finder_app/View/JobSeeker/Home/HomePageJobSeeker.dart';
import 'package:job_finder_app/View/JobSeeker/MyApplications/Controller/MyApplicationsPageController.dart';
import 'package:job_finder_app/View/JobSeeker/MyApplications/MyApplicationsPage.dart';
import 'package:job_finder_app/View/JobSeeker/Settings/Controller/SettingsPageJobSeekerController.dart';
import 'package:job_finder_app/View/JobSeeker/Settings/SettingsPageJobSeeker.dart';
import 'package:provider/provider.dart';

class NavigationPageJobSeekerController with ChangeNotifier {
  int index = 1;

  List<Widget> pages = [
    ChangeNotifierProvider(
      create:
          (context) =>
              MyApplicationsPageController()..GetAllMyApplications(context),
      builder: (context, child) => MyApplicationsPage(),
    ),
    ChangeNotifierProvider(
      create:
          (context) =>
              HomePageJobSeekerController()..GetAllOpportunities(context),
      builder: (context, child) => HomePageJobSeeker(),
    ),

    ChangeNotifierProvider(
      create: (context) => SettingsPageJobSeekerController(),
      builder: (context, child) => SettingsPageJobSeeker(),
    ),
  ];
  ChangeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
