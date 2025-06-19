class Profile {
  int? id;
  String? userName;
  String? role;
  Employer? employer;
  JobSeeker? jobSeeker;
  Center? center;

  Profile({
    this.id,
    this.userName,
    this.role,
    this.employer,
    this.jobSeeker,
    this.center,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    role = json['role'];
    employer =
    json['employer'] != null
        ? new Employer.fromJson(json['employer'])
        : null;
    jobSeeker =
    json['job_seeker'] != null
        ? new JobSeeker.fromJson(json['job_seeker'])
        : null;
    center =
    json['center'] != null ? new Center.fromJson(json['center']) : null;
  }
}

class Employer {
  int? id;
  int? userId;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  int? specializationId;
  var companyLogo;
  int? isVerified;

  Employer({
    this.id,
    this.userId,
    this.companyName,
    this.companyPhone,
    this.companyAddress,
    this.specializationId,
    this.companyLogo,
    this.isVerified,
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
  }
}

class JobSeeker {
  int? id;
  int? userId;
  int? specializationId;
  String? fullName;
  String? address;
  String? phone;
  int? age;
  List<String>? languages;
  int? gpa;
  int? experienceYears;
  List<Skills>? skills;

  JobSeeker({
    this.id,
    this.userId,
    this.specializationId,
    this.fullName,
    this.address,
    this.phone,
    this.age,
    this.languages,
    this.gpa,
    this.experienceYears,
    this.skills,
  });

  JobSeeker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    specializationId = json['specialization_id'];
    fullName = json['full_name'];
    address = json['address'];
    phone = json['phone'];
    age = json['age'];
    languages = json['languages'].cast<String>();
    gpa = json['gpa'];
    experienceYears = json['experience_years'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
  }
}

class Skills {
  int? id;
  String? name;
  Pivot? pivot;

  Skills({this.id, this.name, this.pivot});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? jobSeekerId;
  int? skillId;

  Pivot({this.jobSeekerId, this.skillId});

  Pivot.fromJson(Map<String, dynamic> json) {
    jobSeekerId = json['job_seeker_id'];
    skillId = json['skill_id'];
  }
}

class Center {
  int? id;
  int? userId;
  String? centerName;
  String? centerAddress;

  Center({this.id, this.userId, this.centerName, this.centerAddress});

  Center.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    centerName = json['center_name'];
    centerAddress = json['center_address'];
  }
}
