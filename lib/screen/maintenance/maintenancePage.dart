import 'dart:io';

import 'package:app_bu/screen/maintenance/dataAccount.dart';
import 'package:app_bu/screen/maintenance/login_mtn.dart';
import 'package:app_bu/screen/maintenance/statusBar_mtn.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaintenancePage extends StatefulWidget {
  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String nameUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    checkPre2();
    aboutNotofication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nameUser == null ? 'หน้าหลัก' : '$nameUser Login',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.yellow,
            ),
            onPressed: () {
              myAlert();
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyStyle().showLogo2(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ฝ่ายช่างซ่อมบำรุง',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Kanit',
                      color: Colors.blueAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: listButton(),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue.shade200,
                  ),
                  child: IconButton(
                      onPressed: () {
                        routed(UserDataMTN());
                      },
                      icon: Icon(Icons.assignment_ind)))
            ],
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

  Future<Null> checkPre2() async {
    try {
      FirebaseMessaging firebase = FirebaseMessaging();
      String token = await firebase.getToken();
      print('token =========$token');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String autoID = preferences.getString('autoID');
      print('autoID ===== $autoID');

      if (autoID != null && autoID.isNotEmpty) {
        String path =
            '${Myconstant().domain}/appkk/editTokenWhereAutoID.php?isAdd=true&mtn_autoID=$autoID&token_mtn=$token';
        await Dio().get(path).then((value) {
          print('==========Update Token Success============');
          // route(MaintenancePage());
        });
      }
    } catch (e) {}
  }

  Widget listButton() {
    // ignore: deprecated_member_use
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.blue.shade50,
        onPressed: () {
          routed(ListdataMTN());
        },
        child: Text(
          'รายการแจ้งเหตุขัดข้อง',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Kanit',
          ),
        ),
      ),
    );
  }

  Future<Null> routed(Widget routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('idMTN');
    preferences.getString('autoID');
    preferences.getString('nameMTN');
    preferences.getString('lastName');
    preferences.getString('tokenMTN');
    preferences.getString('Phone');

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    route(Login_Mtn());
  }

  Future<Null> route(Widget routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('id');
    print('pre >>>>>>>> $preferences');
    Navigator.of(context)
    .pushNamedAndRemoveUntil('/loginMTN', (Route<dynamic> route) => false);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('ลงชื่อออก'),
              content: Text('ลงชื่อออกหรือไม่????'),
              actions: <Widget>[
                cancleButton(),
                okButton(),
              ]);
        });
  }

  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'ยกเลิก',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget okButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        signout();
      },
      child: Text('ตกลง'),
    );
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('nameMTN'); //
    });
  }
}
