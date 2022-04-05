import 'dart:convert';
import 'dart:io';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/user/menuBar.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//Explicit
  final textFill = GlobalKey<FormState>();
  String nameStr, studentidStr, passwordStr, moreStr;
  String chooseRadio, _chosenValue;
  String chooseRadio2;
  String idLogin;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  Response response;
  ProgressDialog pr;

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
          Text("มีเหตุขัดข้องแจ้งเข้ามาจากผู้ใช้งาน"),
          background: Colors.purple,
        );
      });
    } else if (Platform.isIOS) {
      print('About Noti Work........IOS');
    }
  }

  Future<Null> registerThread() async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    String url =
        '${Myconstant().domain}/appkk/addUser.php?isAdd=true&id&student_id=$studentidStr&name=$nameStr&password=$passwordStr&level=user&gender=$_chosenValue&position=$chooseRadio2&token=$token';
    try {
      Response response = await Dio().get(url);
      print('----------$response');
      var result = json.decode(response.data);
      print('----------$result');
    } catch (e) {}
  }

  Future<Null> signIn() async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String level = preferences.getString('level');
    idLogin = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getWhereStudent_id.php?isAdd=true&student_id=$studentidStr';
    try {
      String path =
          '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&student_id=$studentidStr&token=$token';
      print('idLogin ===== $studentidStr');
      await Dio()
          .get(path)
          .then((value) => print('==========Update Success============'));

      Response response = await Dio().get(url);
      print('res >>>>>>>>> $response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (passwordStr != null) {
          String level = userModel.level;
          if (level == 'admin') {
            setState(() {
              MyStyle().showProgress(Colors.teal);
            });

            routed(Admin(), userModel);
            Fluttertoast.showToast(
              msg: "Admin เข้าสู่ระบบสำเร็จ",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
          } else {
            setState(() {
              MyStyle().showProgress(Colors.teal);
            });

            routed(Bar(), userModel);
            Fluttertoast.showToast(
              msg: "เข้าสู่ระบบสำเร็จ",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "รหัสนักศึกษาหรือรหัสผ่านผิด กรุณากรอกอีกครั้งค่ะ",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      }
    } catch (e) {}
  }

  Future<Null> routed(Widget routeName, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('name', userModel.name);
    preferences.setString('level', userModel.level);
    preferences.setString('tokenUSER', userModel.token);

    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context)
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  Future<Null> checkPre() async {
    try {
      FirebaseMessaging firebase = FirebaseMessaging();
      String token = await firebase.getToken();
      print('token =========$token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      idLogin = preferences.getString('id');
      print('idLogin ===== $idLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        String path =
            '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&id=$idLogin&token=$token';
        await Dio()
            .get(path)
            .then((value) => print('==========Update Success============'));
      }
    } catch (e) {}
  }

  Future<void> showAlert(String title, String mss) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontFamily: 'Kanit'),
                ),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
              child: Text(
                mss,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Kanit',
                ),
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              )
            ],
          );
        });
  }

  Widget registerButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.deepOrange.shade900,
        child: Text('ลงทะเบียน',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        onPressed: () {
          print(
              '-------------------------------------------------------------------------${response.toString()}');
          print(
              'name = $nameStr, รหัสนักศึกษา = $studentidStr, password = $passwordStr, gender = $chooseRadio , level = user');
          if (nameStr == null ||
              nameStr.isEmpty ||
              studentidStr == null ||
              studentidStr.isEmpty ||
              passwordStr == null ||
              passwordStr.isEmpty ||
              chooseRadio == null ||
              chooseRadio.isEmpty) {
            myAlert('มีช่องว่าง', 'กรุณากรอกข้อมูลให้ครบ');
          } else if (chooseRadio == null) {
            myAlert('โปรดเลือกตัวเลือก', 'คุณไม่ได้เลือกเพศ');
          } else {
            getAllUser();
            print('checkUser');
          }
        });
  }

  Future<Null> checkUser() async {
    String url =
        '${Myconstant().domain}/appkk/getUserWhereUser.php?isAdd=true&student_id=$studentidStr';
    print(
        '---------------------------------------cccccc---------------------------------${response.toString()}');
    try {
      response = await Dio().get(url);
      if (response.toString() == null) {
        registerThread();
        signIn();
        checkPre();
        print('Success');
        pr = ProgressDialog(context,
            type: ProgressDialogType.Normal,
            isDismissible: true,
            showLogs: true);
        Fluttertoast.showToast(
          msg: "ลงทะเบียนสำเร็จ",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        print('55555555555555555555555555555555555555alert');
      }
    } catch (e) {}
  }

  Future<Null> getAllUser() async {
    String url =
        '${Myconstant().domain}/appkk/getUserWhereUser.php?isAdd=true&student_id=$studentidStr';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        print('value >>>>>>>>${value.toString()}');
        print('**********************$value');
        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');
        showAlert(
            "คำเตือน", 'รหัสนักศึกษาหรือชื่อผู้ใช้ $studentidStr มีอยู่แล้ว ');
      } else {
        registerThread();
        signIn();
        checkPre();
        print('Success');
        pr = ProgressDialog(context,
            type: ProgressDialogType.Normal,
            isDismissible: true,
            showLogs: true);
        Fluttertoast.showToast(
          msg: "ลงทะเบียนสำเร็จ",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    });
  }

  Future<Null> route(UserModel userModel, Widget route) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => route);
    Navigator.of(context).push(materialPageRoute);
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

  // Define an async function to initialize FlutterFire
  Widget nameForm() {
    return TextFormField(
      controller: textEditingController,
      onChanged: (value) => nameStr = value.trim(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'ชื่อ - นามสกุล',
        labelStyle: TextStyle(
          color: Colors.pink.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget studentIdForm() {
    return TextFormField(
      controller: textEditingController2,
      onChanged: (value) => studentidStr = value.trim(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'รหัสนักศึกษาหรือชื่อผู้ใช้',
        labelStyle: TextStyle(
          color: Colors.pink.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget passwordForm() {
    return TextFormField(
      controller: textEditingController3,
      onChanged: (value) => passwordStr = value.trim(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'รหัสผ่าน',
        labelStyle: TextStyle(
          color: Colors.orange.shade600,
          fontWeight: FontWeight.bold,
        ),
      ),
      obscureText: true,
    );
  }

  Widget moreForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController4,
        onChanged: (value) => chooseRadio2 = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelText: 'ระบุตำแหน่งอื่นๆ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget femaleRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 125.0,
            child: Row(
              children: [
                Radio(
                  value: 'Female',
                  groupValue: chooseRadio,
                  onChanged: (value) {
                    setState(() {
                      chooseRadio = value;
                    });
                  },
                ),
                Text(
                  'เพศหญิง',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Widget maleRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 125.0,
            child: Row(
              children: [
                Radio(
                  value: 'male',
                  groupValue: chooseRadio,
                  onChanged: (value) {
                    setState(() {
                      chooseRadio = value;
                    });
                  },
                ),
                Text(
                  'เพศชาย',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Widget teacherRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 125.0,
            child: Row(
              children: [
                Radio(
                  value: 'teacher',
                  groupValue: chooseRadio2,
                  onChanged: (value) {
                    setState(() {
                      chooseRadio2 = value;
                    });
                  },
                ),
                Text(
                  'อาจารย์',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Widget officerRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 125.0,
            child: Row(
              children: [
                Radio(
                  value: 'officer',
                  groupValue: chooseRadio2,
                  onChanged: (value) {
                    setState(() {
                      chooseRadio2 = value;
                    });
                  },
                ),
                Text(
                  'เจ้าหน้าที่',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Widget studentRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 125.0,
            child: Row(
              children: [
                Radio(
                  value: 'student',
                  groupValue: chooseRadio2,
                  onChanged: (value) {
                    setState(() {
                      chooseRadio2 = value;
                    });
                  },
                ),
                Text(
                  'นักศึกษา',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Widget dropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'เพศ : ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Sarabun'),
        ),
        SizedBox(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber[100],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButton<String>(
              focusColor: Colors.white,
              value: _chosenValue,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: <String>['หญิง', 'ชาย']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Sarabun'),
                  ),
                );
              }).toList(),
              hint: Center(
                child: Text(
                  "เลือกเพศ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Sarabun'),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                  print(_chosenValue);
                  print('66666666666' + value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.yellow.shade800,
          title: Text(
            'สมัครสมาชิก',
            style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              })),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.yellow[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Form(
              key: textFill,
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  nameForm(),
                  SizedBox(
                    height: 10,
                  ),
                  studentIdForm(),
                  SizedBox(
                    height: 10,
                  ),
                  passwordForm(),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Column(
                  //       children: [
                  //         Text(
                  //           'เพศ',
                  //           style: TextStyle(fontSize: 18.0),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             femaleRadio(),
                  //             maleRadio(),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  Row(
                    children: [
                      dropDown(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'ตำแหน่ง',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              teacherRadio(),
                              studentRadio(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              officerRadio(),
                              Radio(
                                value: 'more',
                                groupValue: chooseRadio2,
                                onChanged: (value) {
                                  setState(() {
                                    chooseRadio2 = value;
                                  });
                                },
                              ),
                              Text(
                                'ตำแหน่งอื่นๆ ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          moreForm()
                        ],
                      ),
                    ),
                  ),
                  registerButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
