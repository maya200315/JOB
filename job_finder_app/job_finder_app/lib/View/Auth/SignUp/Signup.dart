// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Services/Responsive.dart';
import 'package:job_finder_app/View/Auth/SignUp/Controller/SignupController.dart';
import 'package:job_finder_app/Widgets/TextInput/TextInputCustom.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Consumer<SignupController>(
            builder:
                (context, controller, child) => Form(
                  key: formkey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(child: Text("Register", style: TextStyles.header)),
                      Gap(30),
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
                        controller: controller.usernameController,
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
                        controller: controller.passwordController,
                        type: TextInputType.text,
                      ),
                      Gap(20),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: AppColors.black.withAlpha(50),
                              offset: Offset(0, 3.5),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedRole,
                          borderRadius: BorderRadius.circular(20),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.basic,

                            prefixIcon: Icon(
                              Icons.shield,
                              color: AppColors.active,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            label: Text("Select Role"),
                            labelStyle: TextStyles.inputtitle,
                            contentPadding: EdgeInsets.all(8),
                            isDense: true,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'job_seeker',
                              child: Text('Job Seeker'),
                            ),
                            DropdownMenuItem(
                              value: 'center',
                              child: Text('Center'),
                            ),
                            DropdownMenuItem(
                              value: 'employer',
                              child: Text('Company'),
                            ),
                          ],
                          onChanged: (value) => controller.setRole(value!),
                        ),
                      ),
                      Gap(20),

                      if (controller.selectedRole == 'job_seeker') ...[
                        TextInputCustom(
                          hint: 'Full Name',
                          controller: controller.fullNameController,
                          isrequierd: true,
                          icon: Icon(Icons.person, color: AppColors.primary),
                          type: TextInputType.text,
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'Address',
                          controller:
                              controller
                                  .addressController, // حط كنترولر خاص فيك
                          isrequierd: true,
                          icon: Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                          ),
                          type: TextInputType.text,
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'Phone',
                          controller: controller.phoneController,
                          isrequierd: true,
                          icon: Icon(Icons.phone, color: AppColors.primary),
                          type: TextInputType.phone,
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'Age',
                          controller: controller.ageController,
                          isrequierd: true,
                          icon: Icon(Icons.numbers, color: AppColors.primary),
                          type: TextInputType.number,
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'GPA',
                          controller: controller.gpaController,
                          isrequierd: true,
                          icon: Icon(Icons.school, color: AppColors.primary),
                          type: TextInputType.number,
                        ),
                        Gap(20),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: AppColors.black.withAlpha(50),
                                offset: Offset(0, 3.5),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<int>(
                            // value: ,
                            borderRadius: BorderRadius.circular(20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.basic,

                              prefixIcon: Icon(
                                Icons.shield,
                                color: AppColors.active,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: AppColors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              label: Text("Select Specialization"),
                              labelStyle: TextStyles.inputtitle,
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                            ),
                            items:
                                controller.specializations
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (value) => controller.setSpecialization(value!),
                          ),
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'Experience Years',
                          controller: controller.experienceYearsController,
                          isrequierd: true,
                          icon: Icon(
                            Icons.workspace_premium,
                            color: AppColors.primary,
                          ),
                          type: TextInputType.number,
                        ),
                        Gap(20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: AppColors.black.withAlpha(50),
                                offset: Offset(0, 3.5),
                              ),
                            ],
                          ),
                          child: MultiSelectDialogField(
                            backgroundColor: AppColors.basic,
                            cancelText: Text("Cancel"),

                            chipDisplay: MultiSelectChipDisplay<int>(
                              chipColor: AppColors.primary,
                              textStyle: TextStyles.button,
                            ),
                            confirmText: Text("Ok"),
                            buttonText: Text(
                              "Select Skills",
                              style: TextStyles.inputtitle,
                            ),

                            buttonIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.grey400,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.basic,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            searchable: true,
                            searchHint: "Search",
                            title: Text("Select Skills"),
                            items:
                                controller.skills
                                    .map((e) => MultiSelectItem(e.id, e.name!))
                                    .toList(),
                            listType: MultiSelectListType.LIST,
                            selectedColor: AppColors.primary,
                            onConfirm: (values) => controller.setSkills(values),
                          ),
                        ),
                        Gap(20),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: AppColors.black.withAlpha(50),
                                offset: Offset(0, 3.5),
                              ),
                            ],
                          ),
                          child: MultiSelectDialogField(
                            backgroundColor: AppColors.basic,
                            cancelText: Text("Cancel"),

                            chipDisplay: MultiSelectChipDisplay<String>(
                              chipColor: AppColors.primary,
                              textStyle: TextStyles.button,
                            ),
                            confirmText: Text("Ok"),
                            buttonText: Text(
                              "Select Languages",
                              style: TextStyles.inputtitle,
                            ),

                            buttonIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.grey400,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.basic,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            searchable: true,
                            searchHint: "Search",
                            title: Text("Select Languages"),
                            items: [
                              MultiSelectItem('Arabic', "Arabic"),
                              MultiSelectItem('Engilsh', "Engilsh"),
                              MultiSelectItem('France', "France"),
                            ],
                            listType: MultiSelectListType.LIST,
                            selectedColor: AppColors.primary,
                            onConfirm:
                                (values) => controller.setLanguages(values),
                          ),
                        ),
                      ],

                      if (controller.selectedRole == 'center') ...[
                        TextInputCustom(
                          hint: 'Center Name',
                          controller: controller.centerNameController,
                          isrequierd: true,
                          icon: Icon(Icons.business, color: AppColors.primary),
                          type: TextInputType.text,
                        ),
                        Gap(20),
                        TextInputCustom(
                          hint: 'Center Address',
                          controller: controller.centerAddressController,
                          isrequierd: true,
                          icon: Icon(
                            Icons.location_city,
                            color: AppColors.primary,
                          ),
                          type: TextInputType.text,
                        ),
                      ],

                      if (controller.selectedRole == 'employer') ...[
                        TextInputCustom(
                          hint: 'Company Name',
                          controller: controller.companyNameController,
                          isrequierd: true,
                          icon: Icon(Icons.apartment, color: AppColors.primary),
                          type: TextInputType.text,
                        ),
                        Gap(10),
                        TextInputCustom(
                          hint: 'Company Phone',
                          controller: controller.companyPhoneController,
                          isrequierd: true,
                          icon: Icon(
                            Icons.phone_android,
                            color: AppColors.primary,
                          ),
                          type: TextInputType.phone,
                        ),
                        Gap(10),
                        TextInputCustom(
                          hint: 'Company Address',
                          controller: controller.companyAddressController,
                          isrequierd: true,
                          icon: Icon(
                            Icons.location_city_outlined,
                            color: AppColors.primary,
                          ),
                          type: TextInputType.text,
                        ),
                        Gap(20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: AppColors.black.withAlpha(50),
                                offset: Offset(0, 3.5),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<int>(
                            value: controller.specializationId,
                            borderRadius: BorderRadius.circular(20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.basic,

                              prefixIcon: Icon(
                                Icons.shield,
                                color: AppColors.active,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: AppColors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              label: Text("Select Specialization"),
                              labelStyle: TextStyles.inputtitle,
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                            ),
                            items:
                                controller.specializations
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (value) => controller.setSpecialization(value!),
                          ),
                        ),
                        Gap(20),
                        GestureDetector(
                          onTap:
                              () =>
                                  controller.image == null
                                      ? controller.PickImage()
                                      : null,
                          child: SizedBox(
                            height: 250.h,
                            child: DottedBorder(
                              color: AppColors.primary,
                              radius: Radius.circular(20),
                              borderType: BorderType.RRect,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    controller.image == null
                                        ? Text(
                                          "Company Image (optinal)",
                                          style: TextStyles.title.copyWith(
                                            color: AppColors.active,
                                          ),
                                        )
                                        : Wrap(
                                          alignment: WrapAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          spacing: 10,
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap:
                                                  () =>
                                                      controller.RemoveImage(),
                                              child: Icon(
                                                Icons.delete,
                                                color: AppColors.active,
                                              ),
                                            ),
                                            Image.file(
                                              File(controller.image!.path),
                                            ),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // يمكنك إضافة حقل specialization_id و company_logo
                      ],

                      Gap(30),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            EasyLoading.show();
                            try {
                              var result = await controller.signup(context);
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
                              "Signup",
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
                            "Already have an account?",
                            style: TextStyles.paraghraph.copyWith(
                              color: AppColors.subHeader,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Login",
                              style: TextStyles.button.copyWith(
                                color: AppColors.active,
                              ),
                            ),
                            onPressed: () {
                              controller.toLoginPage(context);
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
