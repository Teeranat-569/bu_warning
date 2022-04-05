library infinite_listview;

import 'dart:convert';
import 'dart:io';

import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/admin/status_finish_admin.dart';
import 'package:app_bu/screen/admin/status_fix_admin.dart';
import 'package:app_bu/screen/admin/status_review_admin.dart';
import 'package:app_bu/screen/admin/status_userwarning_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Listdata extends StatefulWidget {
  @override
  _ListdataState createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  bool loadStatus = true;
  bool status = true;
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsFINISH = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsFIX = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();
  // ignore: deprecated_member_use
  List<WarningModel> warningModelsReview = List();
  @override
  void initState() {
    super.initState();
    showDataFINISH();
    showDataFIX();
    showDataUSERWARNING();
    aboutNotofication();
    showDataReview();
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
          Text("มีเหตุขัดข้องแจ้งเข้ามาจากผู้ใช้งาน"),
          background: Colors.purple,
        );
      });
    } else if (Platform.isIOS) {
      print('About Noti Work........IOS');
    }
  }

  Future<Null> showDataUSERWARNING() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=UserWarning';
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

  Future<Null> showDataFINISH() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=FInish';
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

  Future<Null> showDataFIX() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=Fix';
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
            warningModelsFIX.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future<Null> showDataReview() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=review';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel warningModel2 = WarningModel.fromJson(map);

          setState(() {
            warningModelsReview.add(warningModel2);
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
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Listdata());
                  Navigator.of(context).pushReplacement(materialPageRoute);
                },
                icon: Icon(Icons.refresh)),
          ],
          backgroundColor: Colors.orange[800],
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
                    Text('รีวิว'),
                    Text('(${warningModelsReview.length})'),
                  ],
                ),
              )),
            ],
          ),
          automaticallyImplyLeading: false,
          title: Center(
              child: Text('รายการแจ้งเหตุขัดข้อง',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kanit',
                  ))),
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
