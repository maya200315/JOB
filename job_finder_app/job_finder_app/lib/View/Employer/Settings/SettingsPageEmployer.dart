import 'package:flutter/material.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Controller/ServicesProvider.dart';
import 'package:job_finder_app/View/Employer/Settings/Controller/SettingsPageController.dart';
import 'package:provider/provider.dart';

class SettingsPageEmployer extends StatelessWidget {
  const SettingsPageEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsPageEmployerController>(
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
