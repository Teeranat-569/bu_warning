import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_bu/screen/maintenance/login_mtn.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

class ShowAutoID extends StatefulWidget {
  String autoID, mtn_name, mtn_lastname, phone_mtn, gender, password;

  ShowAutoID(
      {Key key,
      this.autoID,
      this.mtn_name,
      this.mtn_lastname,
      this.phone_mtn,
      this.gender,
      this.password});
  @override
  _ShowAutoIDState createState() => _ShowAutoIDState();
}

class _ShowAutoIDState extends State<ShowAutoID> {
  Random random;
  int i = Random().nextInt(1000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    aboutNotofication();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue[400],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.green,
                    ),
                    Text(
                      'ลงทะเบียนสำเร็จ',
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 30,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'รหัสสำหรับเจ้าหน้าที่ใช้ในการเข้าสู่ระบบ',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'mtn$i',
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 30,
                              color: Colors.pink[700]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      onPressed: () {
                        route(Login_Mtn());
                        addAutoID();
                      },
                      color: Colors.blue[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.login, color: Colors.white),
                            Text(
                              "ไปยังหน้าเข้าสู่ระบบ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  Future<Null> addAutoID() async {
    try {
      String path =
          '${Myconstant().domain}/appkk/editAutoIDWherenameMTN.php?isAdd=true&mtn_name=${widget.mtn_name}&mtn_autoID=mtn$i';
      await Dio().get(path).then(
          (value) => print('==========Update AutoID Success============'));
    } catch (e) {}
  }

  void route(Widget routeName) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => routeName,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
