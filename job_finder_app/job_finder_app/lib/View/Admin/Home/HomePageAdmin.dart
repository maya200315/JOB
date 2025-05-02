import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Controller/ServicesProvider.dart';
import 'package:job_finder_app/View/Admin/Home/Controller/HomePageAdminController.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageAdminController>(
      builder:
          (context, controller, child) => DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  GestureDetector(
                    onTap: () => ServicesProvider.logout(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.logout, color: AppColors.basic),
                    ),
                  ),
                ],
                title: Text("Dashboard"),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text("Companies Pending")),
                    Tab(child: Text("Specializations")),
                    Tab(child: Text("Skills")),
                  ],
                ),
              ),

              body: TabBarView(
                children: [
                  ListView(
                    padding: EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Companies Pending", style: TextStyles.title),
                          GestureDetector(
                            onTap:
                                () => controller.GetAllCompanyPending(context),
                            child: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      Gap(10),
                      controller.isloadingemployers
                          ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.active,
                            ),
                          )
                          : controller.employers.isEmpty
                          ? Column(
                            children: [
                              Icon(Symbols.database_off),
                              Text("No data available"),
                            ],
                          )
                          : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.employers.length,
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("User Name Company"),
                                                  Text(
                                                    controller
                                                        .employers[index]
                                                        .user!
                                                        .userName!,
                                                    style: TextStyles.pramed,
                                                  ),
                                                  Gap(10),

                                                  Text("Company Name"),
                                                  Text(
                                                    controller
                                                        .employers[index]
                                                        .companyName!,
                                                    style: TextStyles.pramed,
                                                  ),
                                                  Gap(10),
                                                  Text("Company Address"),
                                                  Text(
                                                    controller
                                                        .employers[index]
                                                        .companyAddress!,
                                                    style: TextStyles.pramed,
                                                  ),
                                                  Gap(10),
                                                  Text("Company Phone"),
                                                  Text(
                                                    controller
                                                        .employers[index]
                                                        .companyPhone!,
                                                    style: TextStyles.pramed,
                                                  ),
                                                  Gap(10),
                                                  Text("Specialization"),
                                                  Text(
                                                    controller
                                                        .employers[index]
                                                        .specialization!
                                                        .name!,
                                                    style: TextStyles.pramed,
                                                  ),
                                                  Gap(10),
                                                  Text("Verification"),
                                                  Text(
                                                    controller
                                                            .employers[index]
                                                            .isVerified ??
                                                        'No',
                                                    style: TextStyles.pramed,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.basic,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 7,
                                                      color: AppColors.black
                                                          .withAlpha(50),
                                                      offset: Offset(0, 3.5),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: AppColors.active,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: FadeInImage.assetNetwork(
                                                    width: 150,
                                                    height: 150,
                                                    placeholder:
                                                        'assets/PNG/Logo.png',
                                                    image:
                                                        "${AppApi.urlimage}${controller.employers[index].companyLogo}",
                                                    imageErrorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Image.asset(
                                                          width: 150,
                                                          height: 150,
                                                          'assets/PNG/Logo.png',
                                                        ),
                                                  ),
                                                ),
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
                                                  () =>
                                                      controller.DialogApproveOrRejectCompany(
                                                        context,
                                                        controller
                                                            .employers[index],
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
                                                      controller.DialogApproveOrRejectCompany(
                                                        context,
                                                        controller
                                                            .employers[index],
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
                  ListView(
                    padding: EdgeInsets.all(8),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("All Specializations", style: TextStyles.title),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () => controller.GetAllSpecializations(
                                      context,
                                    ),
                                child: Icon(Icons.refresh),
                              ),
                              Gap(10),
                              ElevatedButton.icon(
                                onPressed:
                                    () => controller.DialogAddSpecialization(
                                      context,
                                    ),
                                label: Text("Add"),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(10),
                      controller.isloadingspecializations
                          ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.active,
                            ),
                          )
                          : controller.specializations.isEmpty
                          ? Column(
                            children: [
                              Icon(Symbols.database_off),
                              Text("No data available"),
                            ],
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.specializations.length,
                            itemBuilder:
                                (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Container(
                                    height: 50,
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
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller
                                                  .specializations[index]
                                                  .name!,
                                              style: TextStyles.paraghraph,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:
                                                () => controller.DialogDeleteSpecialization(
                                                  context,
                                                  controller
                                                      .specializations[index],
                                                ),
                                            child: Icon(
                                              Icons.delete,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                    ],
                  ),
                  ListView(
                    padding: EdgeInsets.all(8),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("All Skills", style: TextStyles.title),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.GetAllSkills(context),
                                child: Icon(Icons.refresh),
                              ),
                              Gap(10),
                              ElevatedButton.icon(
                                onPressed:
                                    () => controller.DialogAddSkill(context),
                                label: Text("Add"),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(10),
                      controller.isloadingskills
                          ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.active,
                            ),
                          )
                          : controller.skills.isEmpty
                          ? Column(
                            children: [
                              Icon(Symbols.database_off),
                              Text("No data available"),
                            ],
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.skills.length,
                            itemBuilder:
                                (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Container(
                                    height: 50,
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
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.skills[index].name!,
                                              style: TextStyles.paraghraph,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:
                                                () =>
                                                    controller.DialogDeleteSkill(
                                                      context,
                                                      controller.skills[index],
                                                    ),
                                            child: Icon(
                                              Icons.delete,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ],
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
    );
  }
}
