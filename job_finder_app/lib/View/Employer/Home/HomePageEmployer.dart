import 'package:flutter/material.dart';
import 'package:job_finder_app/View/Employer/Home/Controller/HomePageEmployerController.dart';
import 'package:provider/provider.dart';

class HomePageEmployer extends StatelessWidget {
  const HomePageEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageEmployerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(title: Text("Home Page"), centerTitle: true),
          ),
    );
  }
}
