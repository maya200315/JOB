import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Services/Responsive.dart';
import 'package:job_finder_app/View/Auth/Login/Controller/LoginController.dart';
import 'package:job_finder_app/Widgets/TextInput/TextInputCustom.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Gap(120),
          Center(child: Text("Login", style: TextStyles.header)),
          Gap(30),
          Consumer<LoginController>(
            builder:
                (context, controller, child) => Form(
                  key: keyform,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TextInputCustom(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'The user name field must be a required.';
                          }
                          return null;
                        },
                        isrequierd: true,
                        icon: Icon(Icons.person, color: AppColors.primary),
                        hint: "User name",
                        ispassword: false,
                        controller: controller.usernamecontroller,
                        type: TextInputType.text,
                      ),
                      Gap(20),
                      TextInputCustom(
                        validator: (p0) {
                          if (p0!.length < 8) {
                            return "The password field must be at least 8 characters.";
                          }
                          return null;
                        },
                        isrequierd: true,
                        icon: Icon(
                          Icons.lock_outline,
                          color: AppColors.primary,
                        ),
                        hint: "Password",
                        ispassword: true,
                        controller: controller.passwordcontroller,
                        type: TextInputType.text,
                      ),
                      Gap(30),
                      GestureDetector(
                        onTap: () async {
                          if (keyform.currentState!.validate()) {
                            EasyLoading.show();
                            try {
                              var result = await controller.Login(context);
                              result.fold(
                                (l) {
                                  EasyLoading.showError(l.message);
                                  EasyLoading.dismiss();
                                },
                                (r) {
                                  EasyLoading.dismiss();
                                },
                              );
                            } catch (e) {
                              EasyLoading.dismiss();
                            }
                          }
                        },
                        child: Container(
                          width: Responsive.getWidth(context) * .4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.basic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyles.paraghraph.copyWith(
                              color: AppColors.subHeader,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Signup",
                              style: TextStyles.button.copyWith(
                                color: AppColors.active,
                              ),
                            ),
                            onPressed: () {
                              controller.toSignUpPage(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
