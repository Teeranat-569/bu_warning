import 'dart:io';
import 'package:app_bu/screen/user/contact.dart';
import 'package:app_bu/screen/user/main.dart';
import 'package:app_bu/screen/user/statusBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Bar extends StatefulWidget {
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  // ignore: unused_field
  PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
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

  // Future<void> showAlert(String title, String message) async {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(title),
  //           content: Text(message),
  //           actions: <Widget>[
  //             // ignore: deprecated_member_use
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('ตกลง'),
  //             )
  //           ],
  //         );
  //       });
  // }

  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              title: Text(
                'ลงชื่อออก',
                style: TextStyle(fontFamily: 'Kanit'),
              ),
              content: Text('คุณต้องการลงชื่อออกหรือไม่?'),
              actions: <Widget>[
                cancleButton(),
                okButton(),
              ]);
        });
  }

  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.grey[200],
      onPressed: () {
        // Navigator.of(context).pop();
        route(Bar());
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
      color: Colors.grey[200],
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () {
        signOut();
      },
      child: Text(
        'ตกลง',
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  Future<Null> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              backgroundColor: Colors.teal[400],
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  bottom: 1.0,
                ),
                child: TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        size: 20,
                      ),
                    ),
                    Tab(
                        icon: Icon(
                      Icons.article,
                      size: 20,
                    )),
                    Tab(
                      icon: Icon(
                        Icons.contacts,
                        size: 20,
                      ),
                    ),
                    Tab(
                      child: IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        onPressed: () {
                          myAlert();
                        },
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 8.0,
                    ),
                    insets: EdgeInsets.only(
                      bottom: 44,
                    ),
                  ),
                  unselectedLabelColor: Colors.black,
                ),
              ),
              body: TabBarView(
                children: [
                  ShowlistMain(),
                  Listdata(),
                  ShowlistContact(),
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
            ),
          ],
        ),
      ),
    );
  }
}
