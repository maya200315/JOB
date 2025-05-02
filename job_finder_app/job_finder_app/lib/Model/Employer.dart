import 'package:job_finder_app/Model/Specialization.dart';
import 'package:job_finder_app/Model/User.dart';

class Employer {
  int? id;
  int? userId;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  int? specializationId;
  String? companyLogo;
  var isVerified;
  User? user;
  Specialization? specialization;

  Employer({
    this.id,
    this.userId,
    this.companyName,
    this.companyPhone,
    this.companyAddress,
    this.specializationId,
    this.companyLogo,
    this.isVerified,
    this.user,
    this.specialization,
  });

  Employer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    specializationId = json['specialization_id'];
    companyLogo = json['company_logo'];
    isVerified = json['is_verified'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    specialization =
        json['specialization'] != null
            ? new Specialization.fromJson(json['specialization'])
            : null;
  }
}
