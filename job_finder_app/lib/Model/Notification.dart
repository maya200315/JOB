class Notifications {
  int? id;
  int? userId;
  String? title;
  String? message;

  Notifications({this.id, this.userId, this.title, this.message});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'];
  }
}
