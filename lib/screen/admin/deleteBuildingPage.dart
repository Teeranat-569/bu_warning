import 'dart:io';
import 'package:app_bu/screen/admin/addBuilding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../user/login.dart';
import 'deleteBuilding_buildkk.dart';
import 'deleteBuilding_floor.dart';
import 'deleteBuilding_numRoom.dart';
import 'delete_Buildings.dart';

class DelBuildingPage extends StatefulWidget {
  @override
  _DelBuildingPageState createState() => _DelBuildingPageState();
}

class _DelBuildingPageState extends State<DelBuildingPage> {
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
        print('***************************************Noti OnLunch');
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

//ออกจากระบบสู่หน้า Login
  Future<Null> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Authen());
    Navigator.of(context).pushReplacement(materialPageRoute);
  }

//ปุ่มไปยังรายการแจ้งเหตุ
  Widget buildkkButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.orange.shade100,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => DelBuildKK());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Text(
        'อาคาร',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }

//ปุ่มสถิติความพึงพอใจ
  Widget floorScore() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.orange.shade100,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => DelFloor());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Text(
        'ชั้น',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }

//ปุ่มข้อมูลผู้ใช้
  Widget numRoom() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.orange.shade100,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => DelNumroom());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Text(
        'ลำดับห้อง',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }

//ปุ่มเพิ่มสถานที่
  Widget addBuild() {
    // ignore: deprecated_member_use
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.blue.shade600,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => AddBuild());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Text(
            'เพิ่มสถานที่',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

//ลบสถานที่
  Widget deleteBuilding() {
    // ignore: deprecated_member_use
    return RaisedButton(
      // padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red.shade600,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Delete());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            'ลบสถานที่',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

//แสดงโลโก้
  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/delete.png'),
    );
  }

//ปุ่มออกจากระบบ
  Widget signoutButton() {
    return IconButton(
      icon: Icon(
        Icons.exit_to_app,
      ),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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

//ปุ่มตกลง
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

//ปุ่มยกเลิก
  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.grey[200],
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'ยกเลิก',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลบสถานที่',
          style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
        ),
        toolbarHeight: 40,
        backgroundColor: Colors.orange.shade600,
      ),
      body: Container(
        color: Colors.orange.shade600,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: showLogo(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildkkButton(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: floorScore(),
                ),

                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: numRoom(),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
