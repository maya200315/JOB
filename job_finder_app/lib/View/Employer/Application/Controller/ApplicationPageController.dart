import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Model/JobApplication.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';

class ApplicationPageController with ChangeNotifier {
  static NetworkClient client = NetworkClient(http.Client());
  int? id_job;
  bool isloadingjobapplications = false;
  List<JobApplication> jobapplications = [];

  initstate(value) {
    id_job = value;
  }

  Future<Either<Failure, bool>> GetAllMyApplicants(BuildContext context) async {
    isloadingjobapplications = true;
    jobapplications.clear();
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetAllMyApplicants(id_job!),
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          jobapplications.add(JobApplication.fromJson(element));
        }
        isloadingjobapplications = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        isloadingjobapplications = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingjobapplications = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingjobapplications = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingjobapplications = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> ApproveApplication(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.ApproveApplication(id),
        requestType: RequestType.PUT,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllMyApplicants(context);
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
        GetAllMyApplicants(context);
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

  DialogApproveOrRejectApplication(
    BuildContext context,
    JobApplication jobapplication,
    bool status,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("${status ? 'Approve' : "Reject"} Application"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to ${status ? 'approve' : "reject"} this application?",
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
                        late Either<Failure, bool> result;
                        if (status) {
                          result = await ApproveApplication(
                            context,
                            jobapplication.applicationId!,
                          );
                        } else {
                          result = await RejectApplication(
                            context,
                            jobapplication.applicationId!,
                          );
                        }
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
}
