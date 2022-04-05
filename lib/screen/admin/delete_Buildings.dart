import 'dart:convert';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  bool loadStatus = true;
  bool status = true;
  String id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        title: Text(
          'ลบสถานที่',
          style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
        ),
        toolbarHeight: 40,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              loadStatus ? MyStyle().showProgress(Colors.amber) : showContent(),
            ],
          ),
        ),
      ),
    );
  }

  void myAlert(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'ลบสถานที่',
                style: TextStyle(
                  fontFamily: 'Kanit',
                ),
              ),
              content: Text(
                'คุณต้องการลบสถานที่นี้ ออกหรือไม่?',
              ),
              actions: <Widget>[
                cancleButton(),
                okButton(index),
              ]);
        });
  }

  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        // Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: Text(
        'ยกเลิก',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget okButton(int index) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        // deleteData();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Delete()));
        Fluttertoast.showToast(
          msg: "ลบสถานที่สำเร็จ",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16,
        );
      },
      child: Text('ตกลง'),
    );
  }

  Widget showContent() {
    return Center(child: Text('ไม่มีการแสดงความคิดเห็น'));
  }

  Future<Null> deleteData(ll) async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    String url =
        // ignore: unnecessary_brace_in_string_interps
        '${Myconstant().domain}/appkk/deleteWhereid.php?isAdd=true&building_name=${ll}';
    // ignore: unnecessary_brace_in_string_interps
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ${ll}');
    try {
      Response response = await Dio().get(url);
      print('----------$response');
    } catch (e) {}
  }
}
