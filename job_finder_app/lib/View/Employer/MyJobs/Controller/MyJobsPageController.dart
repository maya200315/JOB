import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Model/Job.dart';
import 'package:job_finder_app/Model/Specialization.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/Widgets/TextInput/TextInputCustom.dart';

class MyJobsPageController with ChangeNotifier {
  List<Job> jobs = [];
  List<Specialization> specializations = [];
  bool isloadingspecializations = false;
  bool isloadingjobs = false;
  static NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> GetAllMyJobs(BuildContext context) async {
    isloadingjobs = true;
    jobs.clear();
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetAllMyJobs,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          jobs.add(Job.fromJson(element));
        }
        isloadingjobs = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        isloadingjobs = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingjobs = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingjobs = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingjobs = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> RejectApplication(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.RejectApplication(id),
        requestType: RequestType.PUT,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        // GetAllCompanyPending(context);
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  TextEditingController titlejobcontroller = TextEditingController();
  TextEditingController descriptionjobcontroller = TextEditingController();
  TextEditingController locationjobcontroller = TextEditingController();
  TextEditingController salaryjobcontroller = TextEditingController();
  int? specializationId;
  TextEditingController deadlinejobcontroller = TextEditingController();

  void setSpecialization(int SpecializationId) {
    specializationId = SpecializationId;
    notifyListeners();
  }

  Future<Either<Failure, bool>> AddJob(BuildContext context) async {
    try {
      final response = await client.request(
        path: AppApi.AddJob,
        requestType: RequestType.POST,
        body: jsonEncode({
          "title": titlejobcontroller.text,
          "description": descriptionjobcontroller.text,
          "location": locationjobcontroller.text,
          "salary": salaryjobcontroller.text,
          "specialization_id": specializationId,
          "deadline": deadlinejobcontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 201) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllMyJobs(context);
        cleardata();

        return Right(true);
      } else if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> UpdateJob(BuildContext context, int id) async {
    try {
      final response = await client.request(
        path: AppApi.UpdateJob(id),
        requestType: RequestType.PUT,
        body: jsonEncode({
          "title": titlejobcontroller.text,
          "description": descriptionjobcontroller.text,
          "location": locationjobcontroller.text,
          "salary": salaryjobcontroller.text,
          "specialization_id": specializationId,
          "deadline": deadlinejobcontroller.text,
        }),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllMyJobs(context);
        cleardata();

        return Right(true);
      } else if (response.statusCode == 422) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  cleardata() {
    titlejobcontroller.clear();
    descriptionjobcontroller.clear();
    salaryjobcontroller.clear();
    deadlinejobcontroller.clear();
    locationjobcontroller.clear();
    specializationId = null;
  }

  filldata(Job job) {
    titlejobcontroller.text = job.title!;
    deadlinejobcontroller.text = job.deadline!;
    salaryjobcontroller.text = job.salary.toString();
    descriptionjobcontroller.text = job.description!;
    locationjobcontroller.text = job.location!;
    specializationId = job.specialization!.id;
  }

  DialogAddJob(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Add Job"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextInputCustom(
                          controller: titlejobcontroller,
                          hint: "Title",
                          icon: Icon(Icons.title),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: descriptionjobcontroller,
                          hint: "Description",
                          icon: Icon(Icons.notes),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: locationjobcontroller,
                          hint: "Location",
                          icon: Icon(Icons.location_on),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: salaryjobcontroller,
                          hint: "Salary",
                          icon: Icon(Icons.monetization_on_outlined),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: TextInputCustom(
                                controller: deadlinejobcontroller,
                                hint: "Dead Line",
                                icon: Icon(Icons.date_range),
                                enable: false,
                              ),
                            ),
                            Gap(10),
                            StatefulBuilder(
                              builder:
                                  (context, setState) => GestureDetector(
                                    onTap:
                                        () => showDatePicker(
                                          context: context,

                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            Duration(days: 365 * 10),
                                          ),
                                        )..then((value) {
                                          setState(() {
                                            deadlinejobcontroller
                                                .text = DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(value!);
                                          });
                                        }),
                                    child: Center(child: Text("pick")),
                                  ),
                            ),
                          ],
                        ),
                        Gap(10),

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
                            value: specializationId,
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
                                specializations
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) => setSpecialization(value!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();
                      try {
                        Either<Failure, bool> result = await AddJob(context);

                        CustomRoute.RoutePop(context);
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.active,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ok", style: TextStyles.button),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cleardata();

                      CustomRoute.RoutePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyles.pramed.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  DialogUpdateJob(BuildContext context, Job job) {
    filldata(job);
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Update Job"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextInputCustom(
                          controller: titlejobcontroller,
                          hint: "Title",
                          icon: Icon(Icons.title),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: descriptionjobcontroller,
                          hint: "Description",
                          icon: Icon(Icons.notes),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: locationjobcontroller,
                          hint: "Location",
                          icon: Icon(Icons.location_on),
                        ),
                        Gap(10),
                        TextInputCustom(
                          controller: salaryjobcontroller,
                          hint: "Salary",
                          icon: Icon(Icons.monetization_on_outlined),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: TextInputCustom(
                                controller: deadlinejobcontroller,
                                hint: "Dead Line",
                                icon: Icon(Icons.date_range),
                                enable: false,
                              ),
                            ),
                            Gap(10),
                            StatefulBuilder(
                              builder:
                                  (context, setState) => GestureDetector(
                                    onTap:
                                        () => showDatePicker(
                                          context: context,

                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            Duration(days: 365 * 10),
                                          ),
                                        )..then((value) {
                                          setState(() {
                                            deadlinejobcontroller
                                                .text = DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(value!);
                                          });
                                        }),
                                    child: Center(child: Text("pick")),
                                  ),
                            ),
                          ],
                        ),
                        Gap(10),
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
                            value: specializationId,
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
                                specializations
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name!),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) => setSpecialization(value!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();
                      try {
                        Either<Failure, bool> result = await UpdateJob(
                          context,
                          job.id!,
                        );
                        CustomRoute.RoutePop(context);
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.active,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ok", style: TextStyles.button),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cleardata();
                      CustomRoute.RoutePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyles.pramed.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<Either<Failure, bool>> DeleteJob(BuildContext context, int id) async {
    try {
      final response = await client.request(
        path: AppApi.DeleteJob(id),
        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllMyJobs(context);
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        return Left(ResultFailure(data['message']));
      } else {
        return Left(GlobalFailure());
      }
    } catch (e) {
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DialogDeleteJob(BuildContext context, Job job) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Delete Job"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete this job?",
                          style: TextStyles.paraghraph,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show();
                      try {
                        Either<Failure, bool> result = await DeleteJob(
                          context,
                          job.id!,
                        );

                        CustomRoute.RoutePop(context);
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.active,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ok", style: TextStyles.button),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CustomRoute.RoutePop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyles.pramed.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  Future<Either<Failure, bool>> GetAllSpecializations(
    BuildContext context,
  ) async {
    isloadingspecializations = true;

    specializations.clear();
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetAllSpecializations,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          specializations.add(Specialization.fromJson(element));
        }
        isloadingspecializations = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        isloadingspecializations = false;
        notifyListeners();
        CustomDialog.DialogError(context, title: data['message']);
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingspecializations = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingspecializations = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingspecializations = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
