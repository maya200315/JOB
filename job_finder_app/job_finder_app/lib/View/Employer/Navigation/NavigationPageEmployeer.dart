import 'package:flutter/material.dart';
import 'package:job_finder_app/View/Employer/Navigation/Controller/NavigationPageEmployeerController.dart';
import 'package:provider/provider.dart';

class NavigationPageEmployeer extends StatelessWidget {
  const NavigationPageEmployeer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationPageEmployeerController>(
      builder:
          (context, controller, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index,
              onTap: (value) => controller.ChangeIndex(value),
              items: [
                BottomNavigationBarItem(
                  label: "My Jobs",
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
