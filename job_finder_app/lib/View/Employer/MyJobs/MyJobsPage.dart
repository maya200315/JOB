import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/View/Employer/Application/ApplicationPage.dart';
import 'package:job_finder_app/View/Employer/Application/Controller/ApplicationPageController.dart';
import 'package:job_finder_app/View/Employer/MyJobs/Controller/MyJobsPageController.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class MyJobsPage extends StatelessWidget {
  const MyJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyJobsPageController>(
      builder:
          (context, controller, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.active,
              onPressed: () => controller.DialogAddJob(context),
              child: Icon(Icons.add, color: AppColors.basic),
            ),
            appBar: AppBar(title: Text("My Jobs"), centerTitle: true),
            body: ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All My Job", style: TextStyles.title),
                    GestureDetector(
                      onTap: () => controller.GetAllMyJobs(context),
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
                    ? Column(
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
                                        PopupMenuButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          itemBuilder:
                                              (context) => [
                                                PopupMenuItem(
                                                  child: Text("Edit"),
                                                  onTap:
                                                      () =>
                                                          controller.DialogUpdateJob(
                                                            context,
                                                            controller
                                                                .jobs[index],
                                                          ),
                                                ),
                                                PopupMenuItem(
                                                  child: Text("Delete"),
                                                  onTap:
                                                      () =>
                                                          controller.DialogDeleteJob(
                                                            context,
                                                            controller
                                                                .jobs[index],
                                                          ),
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
                                            () => CustomRoute.RouteTo(
                                              context,
                                              ChangeNotifierProvider(
                                                create:
                                                    (context) =>
                                                        ApplicationPageController()
                                                          ..initstate(
                                                            controller
                                                                .jobs[index]
                                                                .id,
                                                          )
                                                          ..GetAllMyApplicants(
                                                            context,
                                                          ),
                                                builder:
                                                    (context, child) =>
                                                        ApplicationPage(),
                                              ),
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
                                              "Browse Applications",
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
