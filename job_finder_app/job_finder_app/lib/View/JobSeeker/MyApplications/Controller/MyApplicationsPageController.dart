import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Model/Course.dart';
import 'package:job_finder_app/Model/Job.dart';
import 'package:job_finder_app/Model/MyApplications.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';

class MyApplicationsPageController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  List<MyApplications> myapplications = [];
  List<Course> courses = [];
  bool isloadingmyapplications = false;
  Future<Either<Failure, bool>> GetAllMyApplications(
    BuildContext context,
  ) async {
    isloadingmyapplications = true;
    myapplications.clear();
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetAllMyApplications,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          myapplications.add(MyApplications.fromJson(element));
        }
        isloadingmyapplications = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        isloadingmyapplications = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingmyapplications = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingmyapplications = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingmyapplications = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  DialogWithdrawJob(BuildContext context, Job job) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Withdraw Application"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to withdraw this application?",
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
                        Either<Failure, bool> result = await WithdrawJob(
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
                      // cleardata();
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

  Future<Either<Failure, bool>> WithdrawJob(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.WithdrawJob(id),
        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllMyApplications(context);
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
}
