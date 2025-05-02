class Skill {
  int? id;
  String? name;

  Skill({this.id, this.name});

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
