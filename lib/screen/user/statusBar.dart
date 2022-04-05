library infinite_listview;

import 'dart:convert';
import 'dart:io';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/user/status_finish.dart';
import 'package:app_bu/screen/user/status_fix.dart';
import 'package:app_bu/screen/user/status_review.dart';
import 'package:app_bu/screen/user/status_userwarning.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Listdata extends StatefulWidget {
  @override
  _ListdataState createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  bool loadStatus = true;
  bool status = true;
  bool loadStatusFIX = true; // have data
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsFIX = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsFINISH = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsReview = List();

  @override
  void initState() {
    super.initState();
    aboutNotofication();
    showDataUSERWARNING();
    showDataFIX();
    showDataFINISH();
    showDataREVIEW();
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

  Future<Null> showDataUSERWARNING() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getDataWhere2Column.php?isAdd=true&idUser=$idUser&status=UserWarning';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel warningModel = WarningModel.fromJson(map);

          setState(() {
            warningModels.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future<Null> route(Widget routeName, WarningModel warningModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', warningModel.id);
    preferences.setString('BuildWarning', warningModel.buildForm);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> showDataFIX() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getDataWhere2Column.php?isAdd=true&idUser=$idUser&status=Fix';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatusFIX = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel warningModel = WarningModel.fromJson(map);

          setState(() {
            warningModelsFIX.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future<Null> showDataFINISH() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getDataWhere2Column.php?isAdd=true&idUser=$idUser&status=FInish';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel warningModel = WarningModel.fromJson(map);

          setState(() {
            warningModelsFINISH.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future<Null> showDataREVIEW() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getDataWhere2Column.php?isAdd=true&idUser=$idUser&status=review';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel warningModel = WarningModel.fromJson(map);

          setState(() {
            warningModelsReview.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Listdata());
                  Navigator.of(context).pushReplacement(materialPageRoute);
                },
                icon: Icon(Icons.refresh)),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            tabs: [
              Tab(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'แจ้งเหตุ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('(${warningModels.length})'),
                  ],
                ),
              )),
              Tab(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ดำเนินการ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('(${warningModelsFIX.length})'),
                  ],
                ),
              )),
              Tab(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'เสร็จสิ้น',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('(${warningModelsFINISH.length})'),
                  ],
                ),
              )),
              Tab(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'รีวิว',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text('(${warningModelsReview.length})'),
                  ],
                ),
              )),
            ],
          ),
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'สถานะแจ้งเหตุขัดข้อง',
            style: TextStyle(fontSize: 16),
          )),
          toolbarHeight: 100,
        ),
        body: TabBarView(
          children: [
            UserWarning(),
            Fix(),
            Finish(),
            ReviewStatus(),
          ],
        ),
      ),
    );
  }
}
