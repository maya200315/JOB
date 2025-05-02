import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/View/Employer/Application/Controller/ApplicationPageController.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationPageController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(title: Text("Application Job"), centerTitle: true),
            body: ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Applications", style: TextStyles.title),
                    GestureDetector(
                      onTap: () => controller.GetAllMyApplicants(context),
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                controller.isloadingjobapplications
                    ? Center(
                      child: CircularProgressIndicator(color: AppColors.active),
                    )
                    : controller.jobapplications.isEmpty
                    ? Column(
                      children: [
                        Icon(Symbols.database_off),
                        Text("No data available"),
                      ],
                    )
                    : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.jobapplications.length,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.basic,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7,
                                        color: AppColors.black.withAlpha(50),
                                        offset: Offset(0, 3.5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Full Name"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .fullName!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),

                                            Text("Phone"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .phone!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Address"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .address!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Age"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .age!
                                                  .toString(),
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Specialization"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .specialization!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Gpa"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .gpa
                                                  .toString(),
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Experience Years"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .jobSeeker!
                                                  .experienceYears
                                                  .toString(),
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Languages"),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  controller
                                                      .jobapplications[index]
                                                      .jobSeeker!
                                                      .languages!
                                                      .map(
                                                        (e) => Text(
                                                          e,
                                                          style:
                                                              TextStyles.pramed,
                                                        ),
                                                      )
                                                      .toList(),
                                            ),
                                            Gap(10),
                                            Text("Skills"),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  controller
                                                      .jobapplications[index]
                                                      .jobSeeker!
                                                      .skills!
                                                      .map(
                                                        (e) => Text(
                                                          e,
                                                          style:
                                                              TextStyles.pramed,
                                                        ),
                                                      )
                                                      .toList(),
                                            ),
                                            Gap(10),
                                            Text("Status"),
                                            Text(
                                              controller
                                                  .jobapplications[index]
                                                  .status,
                                              style: TextStyles.pramed,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (controller.jobapplications[index].status ==
                                    'pending')
                                  Gap(10),
                                if (controller.jobapplications[index].status ==
                                    'pending')
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap:
                                              () =>
                                                  controller.DialogApproveOrRejectApplication(
                                                    context,
                                                    controller
                                                        .jobapplications[index],
                                                    true,
                                                  ),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 7,
                                                  color: AppColors.black
                                                      .withAlpha(50),
                                                  offset: Offset(0, 3.5),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Approve",
                                                style: TextStyles.button,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(5),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap:
                                              () =>
                                                  controller.DialogApproveOrRejectApplication(
                                                    context,
                                                    controller
                                                        .jobapplications[index],
                                                    false,
                                                  ),

                                          child: Container(
                                            height: 40,

                                            decoration: BoxDecoration(
                                              color: AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 7,
                                                  color: AppColors.black
                                                      .withAlpha(50),
                                                  offset: Offset(0, 3.5),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Reject",
                                                style: TextStyles.button,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                    ),
              ],
            ),
          ),
    );
  }
}
