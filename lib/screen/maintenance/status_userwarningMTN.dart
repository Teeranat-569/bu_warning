import 'dart:convert';
import 'dart:io';

import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/maintenance/show_DataMTN.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWarningMTN extends StatefulWidget {
  @override
  _UserWarningMTNState createState() => _UserWarningMTNState();
}

class _UserWarningMTNState extends State<UserWarningMTN> {
  bool loadStatus = true;
  bool status = true; // have data
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();

  @override
  void initState() {
    super.initState();
    showDataUSERWARNING();
    aboutNotofication();
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
    String idUser = preferences.getString('autoID');

    String url =
        '${Myconstant().domain}/appkk/getDataWhere2ColumnMTN.php?isAdd=true&mtn_autoID=$idUser&status=UserWarning';
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

  Widget showContentUserWarning() {
    return status == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'ไม่มีรายกา่รแจ้งเหตุขัดข้อง',
                style: TextStyle(color: Colors.grey),
              )),
            ],
          )
        : showListdata();
  }

  Widget showListdata() {
    return RefreshIndicator(
      onRefresh: showDataUSERWARNING,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 12),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: warningModels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade200,
              ),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  route(ShowIdWarningMTN(), warningModels[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${warningModels[index].nameForm}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              warningModels[index].dateTimeWarning,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (warningModels[index].status == 'UserWarning')
                              Text(
                                'ผู้ใช้แจ้งเหตุ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else if (warningModels[index].status == 'Fix')
                              Text(
                                'กำลังดำเนินการ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else if (warningModels[index].status == 'FInish')
                              Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
          );
        },
      ),
    );
  }

  Future<Null> route(Widget routeName, WarningModel warningModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', warningModel.id);
    preferences.setString('BuildWarning', warningModel.buildForm);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            loadStatus
                ? MyStyle().showProgressMTN()
                : RefreshIndicator(
                    onRefresh: showDataUSERWARNING,
                    child: showContentUserWarning()),
          ],
        ),
      ),
    );
  }
}
