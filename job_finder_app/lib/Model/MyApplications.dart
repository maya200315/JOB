import 'package:job_finder_app/Model/Job.dart';

class MyApplications {
  int? id;
  int? jobId;
  int? jobSeekerId;
  String? status;
  String? appliedAt;
  Job? job;

  MyApplications({
    this.id,
    this.jobId,
    this.jobSeekerId,
    this.status,
    this.appliedAt,
    this.job,
  });

  MyApplications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobSeekerId = json['job_seeker_id'];
    status = json['status'];
    appliedAt = json['applied_at'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }
}
