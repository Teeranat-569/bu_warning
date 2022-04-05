import 'dart:convert';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/admin/Register.dart';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/maintenance/login_mtn.dart';
import 'package:app_bu/utility/bottom_curve_painter.dart';
import 'package:app_bu/utility/gradient_text.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'menuBar.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explicit
  final textFill = GlobalKey<FormState>();
  String studentidStr, passwordStr;
  TextEditingController studentId = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String nameUser;

  @override
  void initState() {
    super.initState();
    checkPre();
  }

  Future<Null> checkPre() async {
    try {
      FirebaseMessaging firebase = FirebaseMessaging();
      String token = await firebase.getToken();
      print('token =========$token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String level = preferences.getString('level');
      String idLogin = preferences.getString('id');
      print('idLogin ===== $idLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        String path =
            '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&id=$idLogin&token=$token';
        await Dio()
            .get(path)
            .then((value) => print('==========Update Success============'));
        String path2 =
            '${Myconstant().domain}/appkk/editTokenWhereIdUser.php?isAdd=true&idUser=$idLogin&token=$token';
        await Dio().get(path2).then((value) =>
            print('==========Update Warning Token Success============'));
      }

      if (level != null && level.isNotEmpty) {
        if (level == 'admin') {
          route(Admin());
        } else if (level == 'user') {
          route(Bar());
        } else if (level == 'maintenance') {
          // route(MtnPage());
        } else {
          route(Authen());
        }
      }
    } catch (e) {}
  }

  Future<Null> checkPre2() async {
    try {
      FirebaseMessaging firebase = FirebaseMessaging();
      String token = await firebase.getToken();
      print('token =========$token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String level = preferences.getString('level');
      String idLogin = preferences.getString('id');
      print('idLogin ===== $idLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        String path =
            '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&id=$idLogin&token=$token';
        await Dio()
            .get(path)
            .then((value) => print('==========Update Success============'));
      }

      if (level != null && level.isNotEmpty) {
        if (level == 'admin') {
          route(Admin());
        } else if (level == 'user') {
          route(Bar());
        } else if (studentidStr == null || passwordStr == null) {
          showAlert(
              'รหัสนักศึกษาหรือชื่อผู้ใช้หรือรหัสผ่านผิด กรุณากรอกอีกครั้งค่ะ');
          print(
              '++++++++++++++++++++++++++++++++++++++++++++++++++++++++*************');
          Fluttertoast.showToast(
            msg: "รหัสนักศึกษาหรือรหัสผ่านผิด กรุณากรอกอีกครั้งค่ะ",
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      } else {}
    } catch (e) {}
  }

  // void initFirebaseMessaging() {
  //   firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //     },
  //   );

  //   firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });

  //   firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     print("Token : $token");
  //   });
  // }

  Future<Null> signIn() async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idLogin2 = preferences.getString('id');
    print('idLogin ===== $idLogin2');

    String url =
        '${Myconstant().domain}/appkk/getUserWhere2Column.php?isAdd=true&student_id=$studentidStr&password=$passwordStr';
    try {
      String path =
          '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&student_id=$studentidStr&token=$token';
      print('studenT_id ===== $studentidStr');
      print('password ===== $passwordStr');
      await Dio()
          .get(path)
          .then((value) => print('==========Update Success============'));
      String path2 =
          '${Myconstant().domain}/appkk/editTokenWhereIdUser.php?isAdd=true&idUser=$idLogin2&token=$token';
      await Dio().get(path2).then((value) =>
          print('==========Update Warning Token Success============'));

      Response response = await Dio().get(url);
      print('res >>>>>>>>> $response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (studentidStr != null || passwordStr != null) {
          String level = userModel.level;
          nameUser = userModel.studentId;
          idLogin2 = userModel.id;
          if (level == 'admin') {
            setState(() {
              MyStyle().showProgress(Colors.teal);
            });

            routed(Admin(), userModel);
            Fluttertoast.showToast(
              msg: "Admin เข้าสู่ระบบสำเร็จ",
              toastLength: Toast.LENGTH_SHORT,
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
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        } else if (studentidStr == null || passwordStr == null) {
          print(
              '///////////////////////////////////----------------------------------');
        }
      }
    } catch (e) {
      showAlert(
          'รหัสนักศึกษาหรือชื่อผู้ใช้หรือรหัสผ่านผิด กรุณากรอกอีกครั้งค่ะ');
    }
  }

  void route(Widget routeName) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => routeName,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> routed(Widget routeName, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('name', userModel.name);
    preferences.setString('level', userModel.level);
    preferences.setString('tokenUSER', userModel.token);
    preferences.setString('nameUser', userModel.studentId);

    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context)
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  Future<void> showAlert(String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            content: Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.grey[200],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              )
            ],
          );
        });
  }

  //Method
  Widget content() {
    return Center(
      child: Form(
        key: textFill,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: Colors.blue.shade200,
                      ),
                      child: IconButton(
                          onPressed: () {
                            MaterialPageRoute materialPageRoute =
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login_Mtn());
                            Navigator.of(context).push(materialPageRoute);
                          },
                          icon: Icon(Icons.perm_identity))),
                )
              ],
            ),
            showAppname(),
            _loginGradientText(),
            SizedBox(
              height: 20.0,
            ),
            studentidText(),
            SizedBox(
              height: 10.0,
            ),
            passwordText(),
            SizedBox(
              height: 20.0,
            ),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget showAppname() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      MyStyle().showLogo(),
    ]);
  }

  GradientText _loginGradientText() {
    return GradientText('Login',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(67, 216, 181, 1.0),
          Color.fromRGBO(51, 165, 161, 1.0),
        ]),
        style: TextStyle(
            fontFamily: 'Mitr', fontSize: 36, fontWeight: FontWeight.bold));
  }

  Widget studentidText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => studentidStr = value.trim(),
          controller: studentId,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusColor: Colors.blue,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.teal,
            ),
            filled: true,
            fillColor: Colors.white70,
            labelText: 'รหัสนักศึกษาหรือชื่อผู้ใช้',
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.height,
        child: TextField(
          onChanged: (value) => passwordStr = value.trim(),
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            focusColor: Colors.blue,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.teal,
            ),
            filled: true,
            fillColor: Colors.white70,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(10.0),
            //   ),
            // ),
            labelText: 'รหัสผ่าน',
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // ignore: deprecated_member_use
        child: RaisedButton(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.teal[900],
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          onPressed: () {
            signIn();
            print('Login');
            // checkPre();
            // print('///////////////$idLogin');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFffffff),
                    const Color(0x5ee0c6),
                  ],
                ),
              ),
              child: SafeArea(
                top: true,
                bottom: false,
                child: Stack(fit: StackFit.expand, children: [
                  ClipPath(
                      clipper: BottomShapeClipper(),
                      child: Container(
                        color: Colors.teal,
                      )),
                  ListView(
                    children: <Widget>[
                      content(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('หากยังไม่มีบัญชีผู้ใช้'),
                          SizedBox(
                            width: 15,
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                              color: Colors.black,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                MaterialPageRoute materialPageRoute =
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Register());
                                Navigator.of(context).push(materialPageRoute);
                              },
                              child: Text(
                                'สมัครสมาชิก',
                                style: TextStyle(color: Colors.yellow),
                              )),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
