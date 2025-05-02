import 'package:job_finder_app/Model/Employer.dart';
import 'package:job_finder_app/Model/Specialization.dart';

class Job {
  int? id;
  int? employerId;
  String? title;
  String? description;
  String? location;
  int? salary;
  int? specializationId;
  String? deadline;
  Specialization? specialization;
  Employer? employer;

  Job({
    this.id,
    this.employerId,
    this.title,
    this.description,
    this.location,
    this.salary,
    this.specializationId,
    this.deadline,
    this.specialization,
    this.employer,
  });

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerId = json['employer_id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    salary = json['salary'];
    specializationId = json['specialization_id'];
    deadline = json['deadline'];
    specialization =
        json['specialization'] != null
            ? new Specialization.fromJson(json['specialization'])
            : null;
    employer =
        json['employer'] != null
            ? new Employer.fromJson(json['employer'])
            : null;
  }
}
