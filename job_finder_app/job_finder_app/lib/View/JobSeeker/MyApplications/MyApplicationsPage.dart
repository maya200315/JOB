import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/View/JobSeeker/MyApplications/Controller/MyApplicationsPageController.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class MyApplicationsPage extends StatelessWidget {
  const MyApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyApplicationsPageController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(title: Text("My Applications"), centerTitle: true),
            body: ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Applications", style: TextStyles.title),
                    GestureDetector(
                      onTap: () => controller.GetAllMyApplications(context),
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                controller.isloadingmyapplications
                    ? Center(
                      child: CircularProgressIndicator(color: AppColors.active),
                    )
                    : controller.myapplications.isEmpty
                    ? Column(
                      children: [
                        Icon(Symbols.database_off),
                        Text("No data available"),
                      ],
                    )
                    : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.myapplications.length,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Title"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .title!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),

                                            Text("Description"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .description!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Location"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .location!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Salary"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .salary
                                                  .toString(),
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Specialization"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .specialization!
                                                  .name!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Dead Line"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .job!
                                                  .deadline!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Status"),
                                            Text(
                                              controller
                                                  .myapplications[index]
                                                  .status!,
                                              style: TextStyles.pramed,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap:
                                            () => controller.DialogWithdrawJob(
                                              context,
                                              controller
                                                  .myapplications[index]
                                                  .job!,
                                            ),
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.active,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                                              "Withdraw Applications",
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
