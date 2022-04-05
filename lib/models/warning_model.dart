class WarningModel {
  String id;
  String dateTimeWarning;
  String time;
  String idUser;
  String nameUser;
  String nameForm;
  String idBuildForm;
  String buildForm;
  String buildKk;
  String floorsPp;
  String numRoom;
  String moreForm;
  String airForm;
  String agency;
  String phone;
  String fileIMG;
  String fileIMG2;
  String status;
  String endDate;
  String timeEnd;
  String token;
  String rate;
  String commentRec;
  String idMtn;
  String mtnAutoID;
  String mtnName;

  WarningModel(
      {this.id,
      this.dateTimeWarning,
      this.time,
      this.idUser,
      this.nameUser,
      this.nameForm,
      this.idBuildForm,
      this.buildForm,
      this.buildKk,
      this.floorsPp,
      this.numRoom,
      this.moreForm,
      this.airForm,
      this.agency,
      this.phone,
      this.fileIMG,
      this.fileIMG2,
      this.status,
      this.endDate,
      this.timeEnd,
      this.token,
      this.rate,
      this.commentRec,
      this.idMtn,
      this.mtnAutoID,
      this.mtnName});

  WarningModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTimeWarning = json['DateTime_warning'];
    time = json['time'];
    idUser = json['idUser'];
    nameUser = json['nameUser'];
    nameForm = json['nameForm'];
    idBuildForm = json['idBuildForm'];
    buildForm = json['buildForm'];
    buildKk = json['build_kk'];
    floorsPp = json['floors_pp'];
    numRoom = json['numRoom'];
    moreForm = json['moreForm'];
    airForm = json['airForm'];
    agency = json['agency'];
    phone = json['phone'];
    fileIMG = json['fileIMG'];
    fileIMG2 = json['fileIMG2'];
    status = json['status'];
    endDate = json['end_date'];
    timeEnd = json['time_end'];
    token = json['token'];
    rate = json['rate'];
    commentRec = json['comment_rec'];
    idMtn = json['id_mtn'];
    mtnAutoID = json['mtn_autoID'];
    mtnName = json['mtn_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DateTime_warning'] = this.dateTimeWarning;
    data['time'] = this.time;
    data['idUser'] = this.idUser;
    data['nameUser'] = this.nameUser;
    data['nameForm'] = this.nameForm;
    data['idBuildForm'] = this.idBuildForm;
    data['buildForm'] = this.buildForm;
    data['build_kk'] = this.buildKk;
    data['floors_pp'] = this.floorsPp;
    data['numRoom'] = this.numRoom;
    data['moreForm'] = this.moreForm;
    data['airForm'] = this.airForm;
    data['agency'] = this.agency;
    data['phone'] = this.phone;
    data['fileIMG'] = this.fileIMG;
    data['fileIMG2'] = this.fileIMG2;
    data['status'] = this.status;
    data['end_date'] = this.endDate;
    data['time_end'] = this.timeEnd;
    data['token'] = this.token;
    data['rate'] = this.rate;
    data['comment_rec'] = this.commentRec;
    data['id_mtn'] = this.idMtn;
    data['mtn_autoID'] = this.mtnAutoID;
    data['mtn_name'] = this.mtnName;
    return data;
  }
}
