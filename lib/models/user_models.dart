class UserModel {
  String id;
  String studentId;
  String name;
  String password;
  String level;
  String gender;
  String position;
  String token;

  UserModel(
      {this.id,
      this.studentId,
      this.name,
      this.password,
      this.level,
      this.gender,
      this.position,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    name = json['name'];
    password = json['password'];
    level = json['level'];
    gender = json['gender'];
    position = json['position'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['level'] = this.level;
    data['gender'] = this.gender;
    data['position'] = this.position;
    data['token'] = this.token;
    return data;
  }
}
