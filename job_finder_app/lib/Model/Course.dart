class Course {
  int? id;
  int? centerId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? durationInHours;
  String? createdAt;
  String? updatedAt;
  Center? center;

  Course({
    this.id,
    this.centerId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.durationInHours,
    this.createdAt,
    this.updatedAt,
    this.center,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['center_id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    durationInHours = json['duration_in_hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    center =
        json['center'] != null ? new Center.fromJson(json['center']) : null;
  }
}

class Center {
  int? id;
  int? userId;
  String? centerName;
  String? centerAddress;
  String? createdAt;
  String? updatedAt;

  Center({
    this.id,
    this.userId,
    this.centerName,
    this.centerAddress,
    this.createdAt,
    this.updatedAt,
  });

  Center.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    centerName = json['center_name'];
    centerAddress = json['center_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
