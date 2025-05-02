import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder_app/Constant/colors.dart';
import 'package:job_finder_app/Constant/text_styles.dart';
import 'package:job_finder_app/Constant/url.dart';
import 'package:job_finder_app/Model/Employer.dart';
import 'package:job_finder_app/Model/Skill.dart';
import 'package:job_finder_app/Model/Specialization.dart';
import 'package:job_finder_app/Services/CustomDialog.dart';
import 'package:job_finder_app/Services/Failure.dart';
import 'package:job_finder_app/Services/NetworkClient.dart';
import 'package:job_finder_app/Services/Routes.dart';
import 'package:job_finder_app/Widgets/TextInput/TextInputCustom.dart';

class HomePageAdminController with ChangeNotifier {
  List<Skill> skills = [];
  List<Specialization> specializations = [];
  List<Employer> employers = [];

  bool isloadingskills = false;
  bool isloadingspecializations = false;
  bool isloadingemployers = false;
  static NetworkClient client = NetworkClient(http.Client());

  Future<Either<Failure, bool>> GetAllCompanyPending(
    BuildContext context,
  ) async {
    isloadingemployers = true;
    employers.clear();
    notifyListeners();
    try {
      final response = await client.request(
        path: AppApi.GetAllCompanyPending,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          employers.add(Employer.fromJson(element));
        }
        isloadingemployers = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        isloadingemployers = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingemployers = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingemployers = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingemployers = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }

  Future<Either<Failure, bool>> ApproveCompany(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.ApproveCompany(id),
        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllCompanyPending(context);
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

  DialogApproveOrRejectCompany(
    BuildContext context,
    Employer employer,
    bool status,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("${status ? 'Approve' : "Reject"} Company"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to ${status ? 'approve' : "reject"} this company?",
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
                          result = await ApproveCompany(context, employer.id!);
                        } else {
                          result = await RejectCompany(context, employer.id!);
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

  Future<Either<Failure, bool>> RejectCompany(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.RejectCompany(id),
        requestType: RequestType.POST,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllCompanyPending(context);
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

  TextEditingController namespecializationcontroller = TextEditingController();
  Future<Either<Failure, bool>> AddSpecialization(BuildContext context) async {
    try {
      final response = await client.request(
        path: AppApi.AddSpecialization,
        requestType: RequestType.POST,
        body: jsonEncode({'name': namespecializationcontroller.text}),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 201) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        namespecializationcontroller.clear();
        GetAllSpecializations(context);
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

  DialogAddSpecialization(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Add Specialization"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextInputCustom(
                          controller: namespecializationcontroller,
                          hint: "Specialization Name",
                          icon: Icon(Icons.title),
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
                        Either<Failure, bool> result = await AddSpecialization(
                          context,
                        );

                        CustomRoute.RoutePop(context);
                        result.fold(
                          (l) {
                            namespecializationcontroller.clear();
                            EasyLoading.showError(l.message);
                            EasyLoading.dismiss();
                          },
                          (r) {
                            namespecializationcontroller.clear();

                            EasyLoading.dismiss();
                          },
                        );
                      } catch (e) {
                        namespecializationcontroller.clear();

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
                      nameskillcontroller.clear();
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

  Future<Either<Failure, bool>> DeleteSpecialization(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.DeleteSpecialization(id),
        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllSpecializations(context);
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

  DialogDeleteSpecialization(
    BuildContext context,
    Specialization specialization,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Delete Specialization"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete this specialization?",
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
                        Either<Failure, bool> result =
                            await DeleteSpecialization(
                              context,
                              specialization.id!,
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

  TextEditingController nameskillcontroller = TextEditingController();
  Future<Either<Failure, bool>> AddSkill(BuildContext context) async {
    try {
      final response = await client.request(
        path: AppApi.AddSkill,
        requestType: RequestType.POST,
        body: jsonEncode({'name': nameskillcontroller.text}),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 201) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        nameskillcontroller.clear();
        GetAllSkills(context);
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

  DialogAddSkill(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Add Skill"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextInputCustom(
                          controller: nameskillcontroller,
                          hint: "Skill Name",
                          icon: Icon(Icons.title),
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
                        Either<Failure, bool> result = await AddSkill(context);

                        CustomRoute.RoutePop(context);
                        result.fold(
                          (l) {
                            nameskillcontroller.clear();
                            EasyLoading.showError(l.message);
                            EasyLoading.dismiss();
                          },
                          (r) {
                            nameskillcontroller.clear();
                            EasyLoading.dismiss();
                          },
                        );
                      } catch (e) {
                        nameskillcontroller.clear();
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
                      nameskillcontroller.clear();
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

  Future<Either<Failure, bool>> DeleteSkill(
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await client.request(
        path: AppApi.DeleteSkill(id),
        requestType: RequestType.DELETE,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomDialog.DialogSuccess(context, title: data['message']);
        GetAllSkills(context);
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

  DialogDeleteSkill(BuildContext context, Skill skill) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Delete Skill"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to delete this skill?",
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
                        Either<Failure, bool> result = await DeleteSkill(
                          context,
                          skill.id!,
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

  Future<Either<Failure, bool>> GetAllSkills(BuildContext context) async {
    isloadingskills = true;
    skills.clear();
    notifyListeners();

    try {
      final response = await client.request(
        path: AppApi.GetAllSkills,
        requestType: RequestType.GET,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var data = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var element in data['data']) {
          skills.add(Skill.fromJson(element));
        }
        isloadingskills = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 401) {
        CustomDialog.DialogError(context, title: data['message']);
        isloadingskills = false;
        notifyListeners();
        return Right(true);
      } else if (response.statusCode == 404) {
        isloadingskills = false;
        notifyListeners();
        return Left(ResultFailure(data['message']));
      } else {
        isloadingskills = false;
        notifyListeners();
        return Left(GlobalFailure());
      }
    } catch (e) {
      isloadingskills = false;
      notifyListeners();
      log(e.toString());
      log("error in this fun");
      return Left(GlobalFailure());
    }
  }
}
