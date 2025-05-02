class JobApplication {
  int? applicationId;
  var status;
  String? appliedAt;
  JobSeeker? jobSeeker;

  JobApplication({this.applicationId, this.appliedAt, this.jobSeeker});

  JobApplication.fromJson(Map<String, dynamic> json) {
    applicationId = json['application_id'];
    status = json['status'];
    appliedAt = json['applied_at'];
    jobSeeker =
        json['job_seeker'] != null
            ? new JobSeeker.fromJson(json['job_seeker'])
            : null;
  }
}

class JobSeeker {
  int? id;
  String? fullName;
  String? address;
  String? phone;
  int? age;
  List<String>? languages;
  double? gpa;
  int? experienceYears;
  String? specialization;
  List<String>? skills;

  JobSeeker({
    this.id,
    this.fullName,
    this.address,
    this.phone,
    this.age,
    this.languages,
    this.gpa,
    this.experienceYears,
    this.specialization,
    this.skills,
  });

  JobSeeker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    address = json['address'];
    phone = json['phone'];
    age = json['age'];
    languages = json['languages'].cast<String>();
    gpa = json['gpa'];
    experienceYears = json['experience_years'];
    specialization = json['specialization'];
    skills = json['skills'].cast<String>();
  }
}
