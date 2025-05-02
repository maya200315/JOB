import 'package:flutter/material.dart';
import 'package:job_finder_app/View/JobSeeker/Navigation/Controller/NavigationPageJobSeekerController.dart';
import 'package:provider/provider.dart';

class NavigationPageJobSeeker extends StatelessWidget {
  const NavigationPageJobSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageJobSeekerController>(
      builder:
          (context, controller, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index,
              onTap: (value) => controller.ChangeIndex(value),
              items: [
                BottomNavigationBarItem(
                  label: "My Applications",
                  icon: Icon(Icons.work),
                ),
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),

                BottomNavigationBarItem(
                  label: "Setting",
                  icon: Icon(Icons.manage_accounts),
                ),
              ],
            ),
            body: controller.pages[controller.index],
          ),
    );
  }
}
