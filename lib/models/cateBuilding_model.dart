class CateBuildingModel {
  String buildId;
  String buildKk;
  String floorspp;
  String numRoom;
  String placeName;

  CateBuildingModel(
      {this.buildId,
      this.buildKk,
      this.floorspp,
      this.numRoom,
      this.placeName});

  CateBuildingModel.fromJson(Map<String, dynamic> json) {
    buildId = json['build_id'];
    buildKk = json['build_kk'];
    floorspp = json['floorspp'];
    numRoom = json['numRoom'];
    placeName = json['placeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['build_id'] = this.buildId;
    data['build_kk'] = this.buildKk;
    data['floorspp'] = this.floorspp;
    data['numRoom'] = this.numRoom;
    data['placeName'] = this.placeName;
    return data;
  }
}
