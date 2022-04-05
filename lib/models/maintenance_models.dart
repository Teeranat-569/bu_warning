class MaintenanceModel {
  String idMtn;
  String mtnAutoID;
  String password;
  String mtnName;
  String mtnLastname;
  String mtnPhone;
  String gender;
  String tokenMtn;

  MaintenanceModel(
      {this.idMtn,
      this.mtnAutoID,
      this.password,
      this.mtnName,
      this.mtnLastname,
      this.mtnPhone,
      this.gender,
      this.tokenMtn});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    idMtn = json['id_mtn'];
    mtnAutoID = json['mtn_autoID'];
    password = json['password'];
    mtnName = json['mtn_name'];
    mtnLastname = json['mtn_lastname'];
    mtnPhone = json['mtn_phone'];
    gender = json['gender'];
    tokenMtn = json['token_mtn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_mtn'] = this.idMtn;
    data['mtn_autoID'] = this.mtnAutoID;
    data['password'] = this.password;
    data['mtn_name'] = this.mtnName;
    data['mtn_lastname'] = this.mtnLastname;
    data['mtn_phone'] = this.mtnPhone;
    data['gender'] = this.gender;
    data['token_mtn'] = this.tokenMtn;
    return data;
  }
}
