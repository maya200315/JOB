import 'package:flutter/material.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Controller/ServicesProvider.dart';
import 'package:job_finder_app/View/JobSeeker/Settings/Controller/SettingsPageJobSeekerController.dart';
import 'package:provider/provider.dart';

class SettingsPageJobSeeker extends StatelessWidget {
  const SettingsPageJobSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsPageJobSeekerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(
              title: Text("Settings Page"),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () => ServicesProvider.logout(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout, color: AppColors.basic),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
