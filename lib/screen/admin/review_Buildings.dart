import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/admin/showGraph_admin.dart';

import 'package:app_bu/screen/user/menuBar.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:app_bu/utility/upper_curve_clipper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user/login.dart';

class Graphscore extends StatefulWidget {
  @override
  _GraphscoreState createState() => _GraphscoreState();
}

class _GraphscoreState extends State<Graphscore> {
  bool loadStatus = true;
  // bool loadStatusB = true;
  bool status = true;
  // bool statusB = true;
  String reStr, idLogin, nameUser;
  String reStrB;
  double avg, re = 0, sum;
  int sumAvg;
  String sumed;
  double avgB, reB = 0, sumB;
  int sumAvgB;
  String sumedB;
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  // ignore: deprecated_member_use
  List<RateModel> rateModels2 = List();
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels = List();
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels2 = List();
  // ignore: deprecated_member_use
  List<DropdownMenuItem<RateModel>> rateModelsB = List();
  // ignore: deprecated_member_use
  var items = List<String>();
  double valued;
  String buildName;
  BuildingModel selectrateModel;
  // ignore: deprecated_member_use
  List<BuildingModel> buildingModels = List();
  // ignore: deprecated_member_use
  List<BuildingModel> filterBuildingModels = List();

  @override
  void initState() {
    super.initState();
    showRate();
    aboutNotofication();
    getAllBuilding();
  }

  Future<Null> route12(Widget routeName, RateModel rateModel,
      BuildingModel buildingModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', rateModel.id);
    preferences.setString('BuildWarning', rateModel.buildForm);
    preferences.setString('BuildName', buildingModel.buildingName);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> aboutNotofication() async {
    print('About Noti Work...');
    if (Platform.isAndroid) {
      print('About Noti Work........Android');
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      // ignore: await_only_futures
      await firebaseMessaging.configure(
          // ignore: missing_return
          onLaunch: (message) {
        print('Noti OnLunch');
        // ignore: missing_return
      }, onResume: (message) {
        print('Noti OnResume ข้อความจากหน้า Home ${message.toString()}');
        // ignore: missing_return
      }, onMessage: (message) {
        print('Noti OnMessage เปิดหน้าของแอพอยู่');
        showSimpleNotification(
          Column(
            children: [
              Text("สถานะการซ่อมบำรุงมีการเปลียนแปลง"),
              Text(
                "โปรดดูที่รายการแจ้งเหตุ",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          background: Colors.yellow[900],
        );
      });
    } else if (Platform.isIOS) {
      print('About Noti Work........IOS');
    }
  }

  Future<Null> showRate() async {
    String url = '${Myconstant().domain}/appkk/getAllRate.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          RateModel rateModel = RateModel.fromJson(map);
          setState(() {
            rateModels.add(rateModel);
            filterRateModels = rateModels;
            avg = double.parse('${rateModel.rate}');
            sumAvg = rateModels.length;
            print('=======================================$avg');

            for (var i = sumAvg; i <= sumAvg; i++) {
              re = re + avg;
            }
            print(
                '///////////////////////////////////////////////////////////////////////$re');
            sum = re / sumAvg;
            sumed = sum.toStringAsFixed(2);
            double sumDou = double.parse('$sumed');
            print(
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++$sumed');
            if (sumDou <= 1.80) {
              reStr = 'น้อยที่สุด';
            } else if (sumDou <= 2.60) {
              reStr = 'น้อย';
            } else if (sumDou <= 3.40) {
              reStr = 'ปานกลาง';
            } else if (sumDou <= 4.20) {
              reStr = 'มาก';
            } else {
              reStr = 'มากที่สุด';
            }
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future<Null> getAllBuilding() async {
    String url = '${Myconstant().domain}/appkk/getAllBuilding.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          BuildingModel rateModel = BuildingModel.fromJson(map);
          setState(() {
            buildingModels.add(rateModel);
            filterBuildingModels = buildingModels;
          });
        }
      } else {
        status = false;
      }
    });
  }

  Widget searchText() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.orange[50],
              prefixIcon: Icon(
                Icons.search,
                color: Colors.orange,
              ),
              labelText: 'ค้นหา',
              labelStyle: TextStyle(color: Colors.orange)),
          onChanged: (value) {
            setState(() {
              filterBuildingModels = buildingModels
                  .where((u) => (u.buildingName
                      .toLowerCase()
                      .contains(value.toLowerCase())))
                  .toList();
            });
          }),
    );
  }

  Widget showListdata() {
    return ListView.separated(
      padding: EdgeInsets.all(5),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: filterBuildingModels.length,
      itemBuilder: (context, index) {
        return
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: () {
                  route12(ShowGraphAdmin(), rateModels[index],
                      buildingModels[index]);
                },
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${filterBuildingModels[index].buildingName}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                color: Colors.orange[100],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.white,
        );
      },
    );
  }

  Widget showGrid() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      childAspectRatio: 16 / 3.5,
      children: <Widget>[],
    );
  }

  Widget sume() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (sumed == null)
                      Text(
                        '0.0',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      )
                    else if (sumed != null)
                      Text(
                        '$sumed',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                  ],
                )),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.indigo.shade50,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("มีความพึงพอใจในระดับ",
                        style: TextStyle(
                          fontSize: 20,
                        ))),
                if (reStr == null)
                  Padding(
                    child: Text(
                      'xxxxxx',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.pink),
                    ),
                    padding: EdgeInsets.all(5.0),
                  )
                else if (reStr != null)
                  Padding(
                    child: Text(
                      '$reStr',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.yellow),
                    ),
                    padding: EdgeInsets.all(5.0),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget showContent() {
    return status == false
        ? Center(child: Text('ไม่มีการแสดงความคิดเห็น'))
        : showListdata();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
    });
  }

  Future showBuildname() async {
    String url =
        '${Myconstant().domain}/appkk/getAllDataWhereNameBuilding.php?isAdd=true&buildForm=$buildName';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          RateModel rateModel2 = RateModel.fromJson(map);
          setState(() {
            buildName = rateModel2.buildForm;
            avg = double.parse('${rateModel2.rate}');
            sumAvg = rateModels.length;
            print('=======================================$avg');

            for (var i = sumAvg; i <= sumAvg; i++) {
              re = re + avg;
            }
            print(
                '///////////////////////////////////////////////////////////////////////$re');
            sum = re / sumAvg;
            sumed = sum.toStringAsFixed(2);
            double sumDou = double.parse('$sumed');
            print(
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++$sumed');
            if (sumDou <= 1.80) {
              reStr = 'น้อยที่สุด';
            } else if (sumDou <= 2.60) {
              reStr = 'น้อย';
            } else if (sumDou <= 3.40) {
              reStr = 'ปานกลาง';
            } else if (sumDou <= 4.20) {
              reStr = 'มาก';
            } else {
              reStr = 'มากที่สุด';
            }
          });
        }
      } else {
        status = false;
      }
    });
  }

  Widget dropDown() {
    return new DropdownButton<BuildingModel>(
      hint: new Text("Select a user"),
      value: selectrateModel,
      onChanged: (BuildingModel newValue) {
        setState(() {
          selectrateModel = newValue;
        });
      },
      items: buildingModels.map((BuildingModel user) {
        return new DropdownMenuItem<BuildingModel>(
          onTap: () {
            showBuildname();

            buildName = user.buildingName;
            print(
                '------------------------------------------------------------$buildName');
          },
          value: user,
          child: new Text(
            user.buildingName,
            style: new TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 00,
      ),
      body: Stack(children: [
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.orange],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              sume(),
              searchText(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: showRate,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        loadStatus ? MyStyle().showProgress(Colors.amber) : showContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class BuildingModel {
  String id;
  String buildingName;

  BuildingModel({this.id, this.buildingName});

  BuildingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingName = json['building_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['building_name'] = this.buildingName;
    return data;
  }
}
