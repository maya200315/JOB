import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/View/JobSeeker/Home/Controller/HomePageJobSeekerController.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class HomePageJobSeeker extends StatelessWidget {
  const HomePageJobSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageJobSeekerController>(
      builder:
          (context, controller, child) => Scaffold(
            appBar: AppBar(title: Text("All Opportunities"), centerTitle: true),
            body: ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All Opportunities", style: TextStyles.title),
                    GestureDetector(
                      onTap: () => controller.GetAllOpportunities(context),
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Gap(10),
                controller.isloadingjobs
                    ? Center(
                      child: CircularProgressIndicator(color: AppColors.active),
                    )
                    : controller.jobs.isEmpty
                    ? controller.courses.isNotEmpty
                        ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.courses.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
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
                                            color: AppColors.black.withAlpha(
                                              50,
                                            ),
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
                                                      .courses[index]
                                                      .title!,
                                                  style: TextStyles.pramed,
                                                ),
                                                Gap(10),

                                                Text("Description"),
                                                Text(
                                                  controller
                                                      .courses[index]
                                                      .description!,
                                                  style: TextStyles.pramed,
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
                        )
                        : Column(
                          children: [
                            Icon(Symbols.database_off),
                            Text("No data available"),
                          ],
                        )
                    : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.jobs.length,
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
                                              controller.jobs[index].title!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),

                                            Text("Description"),
                                            Text(
                                              controller
                                                  .jobs[index]
                                                  .description!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Location"),
                                            Text(
                                              controller.jobs[index].location!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Salary"),
                                            Text(
                                              controller.jobs[index].salary
                                                  .toString(),
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Specialization"),
                                            Text(
                                              controller
                                                  .jobs[index]
                                                  .specialization!
                                                  .name!,
                                              style: TextStyles.pramed,
                                            ),
                                            Gap(10),
                                            Text("Dead Line"),
                                            Text(
                                              controller.jobs[index].deadline!,
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
                                            () => controller.DialogApplyJob(
                                              context,
                                              controller.jobs[index],
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
                                              "Apply Applications",
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
