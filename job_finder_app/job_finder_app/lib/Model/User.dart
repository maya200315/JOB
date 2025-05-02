class User {
  int? id;
  String? userName;
  String? role;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.userName, this.role, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
