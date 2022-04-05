class RateModel {
  String id;
  String idWarning;
  String rate;
  String commentRec;
  String idBuildForm;
  String buildForm;
  String buildKk;
  String floorsPp;
  String numRoom;
  String moreForm;

  RateModel(
      {this.id,
      this.idWarning,
      this.rate,
      this.commentRec,
      this.idBuildForm,
      this.buildForm,
      this.buildKk,
      this.floorsPp,
      this.numRoom,
      this.moreForm});

  RateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idWarning = json['idWarning'];
    rate = json['rate'];
    commentRec = json['comment_rec'];
    idBuildForm = json['idBuildForm'];
    buildForm = json['buildForm'];
    buildKk = json['build_kk'];
    floorsPp = json['floors_pp'];
    numRoom = json['numRoom'];
    moreForm = json['moreForm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idWarning'] = this.idWarning;
    data['rate'] = this.rate;
    data['comment_rec'] = this.commentRec;
    data['idBuildForm'] = this.idBuildForm;
    data['buildForm'] = this.buildForm;
    data['build_kk'] = this.buildKk;
    data['floors_pp'] = this.floorsPp;
    data['numRoom'] = this.numRoom;
    data['moreForm'] = this.moreForm;
    return data;
  }
}
