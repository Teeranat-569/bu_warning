import 'dart:convert';
import 'dart:io';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

class AddBuild extends StatefulWidget {
  @override
  _AddBuildState createState() => _AddBuildState();
}

class _AddBuildState extends State<AddBuild> {
//Explicit
  final textFill = GlobalKey<FormState>();
  String buildingStr, floorsStr, numroomStr;

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
        print('**********************************************Noti OnLunch');

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

//เพิ่มสถานที่ไปยังฐานข้อมูล
  Future<Null> addBuildingThread() async {
    String url =
        '${Myconstant().domain}/appkk/addDatahouse.php?isAdd=true&build_kk=$buildingStr&floors=$buildingStr&build_kk=$buildingStr&build_kk=$buildingStr';
    try {
      Response response = await Dio().get(url);
      print('----------$response');
      var result = json.decode(response.data);
      print('----------$result');
    } catch (e) {}
  }

//ปุ่มเพิ่มสถานที่
  Widget addButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.pink.shade900,
        child: Text('เพิ่มสถานที่',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        onPressed: () {
          if (buildingStr == null || buildingStr.isEmpty) {
            myAlert('มีช่องว่าง', 'กรุณากรอกข้อมูลให้ครบ');
          } else {
            addBuildingThread();
            print('Success');
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) => Admin());
            Navigator.of(context).push(materialPageRoute);
            Fluttertoast.showToast(
              msg: "เพิ่มสถานที่สำเร็จ",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        });
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.warning,
                color: Colors.red,
                size: 40.0,
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  //ช่องกรอกสถานที่
  Widget buildingNameForm() {
    return TextFormField(
      onChanged: (value) => buildingStr = value.trim(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.pink.shade900,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'กรอกเลขห้องและชื่อสถานที่',
        labelStyle: TextStyle(
          color: Colors.pink.shade900,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'เช่น 123 ห้องประชุม',
        helperStyle: TextStyle(
          color: Colors.pink.shade900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

   Widget floors() {
    return TextFormField(
      onChanged: (value) => floorsStr = value.trim(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.pink.shade900,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'กรอกเลขห้องและชื่อสถานที่',
        labelStyle: TextStyle(
          color: Colors.pink.shade900,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'เช่น 123 ห้องประชุม',
        helperStyle: TextStyle(
          color: Colors.pink.shade900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

 Widget numRoom() {
    return TextFormField(
      onChanged: (value) => numroomStr = value.trim(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.pink.shade900,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'กรอกเลขห้องและชื่อสถานที่',
        labelStyle: TextStyle(
          color: Colors.pink.shade900,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'เช่น 123 ห้องประชุม',
        helperStyle: TextStyle(
          color: Colors.pink.shade900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.pink.shade900,
        title: Text(
          'เพิ่มสถานที่',
          style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
        ),
      ),
      body: Form(
        key: textFill,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            buildingNameForm(),
            SizedBox(
              height: 40,
            ),
            addButton(),
          ],
        ),
      ),
    );
  }
}
