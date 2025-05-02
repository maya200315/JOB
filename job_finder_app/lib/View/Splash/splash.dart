// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/View/Splash/Controller/SplashController.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder:
          (context, value, child) => Scaffold(
            body: SafeArea(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/PNG/Logo.png", width: 80.w),
                      Gap(20.h),
                      LoadingAnimationWidget.discreteCircle(
                        color: AppColors.active,
                        secondRingColor: AppColors.secondery,
                        thirdRingColor: AppColors.secondery,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
