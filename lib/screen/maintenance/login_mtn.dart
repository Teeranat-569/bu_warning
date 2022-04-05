import 'dart:convert';
import 'package:app_bu/models/maintenance_models.dart';
import 'package:app_bu/screen/maintenance/RegisterMTN.dart';
import 'package:app_bu/screen/maintenance/maintenancePage.dart';
import 'package:app_bu/screen/user/login.dart';
import 'package:app_bu/utility/bottom_curve_painter.dart';
import 'package:app_bu/utility/gradient_text.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Login_Mtn extends StatefulWidget {
  @override
  _Login_MtnState createState() => _Login_MtnState();
}

class _Login_MtnState extends State<Login_Mtn> {
  //Explicit
  final textFill = GlobalKey<FormState>();
  String mtnStr, passwordStr, idLogin;
  TextEditingController mtnID = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String nameUser;
  @override
  void initState() {
    super.initState();
    checkPre2();
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

  Future<Null> signIn() async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');

    String url =
        '${Myconstant().domain}/appkk/getUserWhere2ColumnMTN.php?isAdd=true&mtn_autoID=$mtnStr&password=$passwordStr';
    try {
      String path =
          '${Myconstant().domain}/appkk/editTokenWhereAutoID.php?isAdd=true&mtn_autoID=$mtnStr&token_mtn=$token';
      print('AutoID ===== $mtnStr');
      print('password ===== $passwordStr');
      await Dio()
          .get(path)
          .then((value) => print('==========Update Token Success============'));

      Response response = await Dio().get(url);
      print('res >>>>>>>>> $response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');
      for (var map in result) {
        MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
        if (result != null || result != null) {
          setState(() {
            MyStyle().showProgress(Colors.blue);
          });

          routed(MaintenancePage(), maintenanceModel);
          Fluttertoast.showToast(
            msg: "เข้าสู่ระบบสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
          // }
        } else if (result == null) {
          print(
              '///////////////////////////////////----------------------------------');
        }
      }
    } catch (e) {
      print(
          '///////////////////////////////////----------------------------------');
      showAlert('รหัสเจ้าหน้าที่หรือรหัสผ่านผิด กรุณากรอกอีกครั้งค่ะ');
    }
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
                child: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  void route(Widget routeName) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => routeName,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> routed(
      Widget routeName, MaintenanceModel maintenanceModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idMTN', maintenanceModel.idMtn);
    preferences.setString('autoID', maintenanceModel.mtnAutoID);
    preferences.setString('nameMTN', maintenanceModel.mtnName);
    preferences.setString('lastName', maintenanceModel.mtnLastname);
    preferences.setString('tokenMTN', maintenanceModel.tokenMtn);
    preferences.setString('Phone', maintenanceModel.mtnPhone);
    print(maintenanceModel.idMtn);
    print(maintenanceModel.mtnName);
    print(maintenanceModel.mtnLastname);
    print(maintenanceModel.tokenMtn);
    print(maintenanceModel.password);
    print(maintenanceModel.mtnPhone);
    print(maintenanceModel.mtnAutoID);

    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context)
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
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
                        color: Colors.teal.shade400,
                      ),
                      child: IconButton(
                          onPressed: () {
                            MaterialPageRoute materialPageRoute =
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Authen());
                            Navigator.of(context).push(materialPageRoute);
                          },
                          icon: Icon(
                            Icons.campaign,
                            size: 30,
                            color: Colors.white,
                          ))),
                )
              ],
            ),
            showAppname(),
            _loginGradientText(),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: mtnIDText(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: passwordText(),
            ),
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
      MyStyle().showLogo2(),
    ]);
  }

  GradientText _loginGradientText() {
    return GradientText('Maintenance',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(33, 182, 255, 1.0),
          Color.fromRGBO(183, 227, 249, 1.0),
        ]),
        style: TextStyle(
            fontFamily: 'Mitr', fontSize: 36, fontWeight: FontWeight.bold));
  }

  Widget mtnIDText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => mtnStr = value.trim(),
          controller: mtnID,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusColor: Colors.blue,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            filled: true,
            fillColor: Colors.white70,
            hoverColor: Colors.blue,
            labelText: 'รหัสเจ้าหน้าที่',
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
            focusColor: Colors.teal,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.blue,
            ),
            filled: true,
            fillColor: Colors.white70,
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
          color: Colors.blue[900],
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          onPressed: () {
            signIn();
            print('Login');
            checkPre2();
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
                    const Color(0x42ecf5),
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
                        color: Colors.blue,
                      )),
                  ListView(
                    children: <Widget>[
                      content(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('หากยังไม่มีบัญชีเจ้าหน้าที่โปรด'),
                          SizedBox(
                            width: 15,
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                              color: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                MaterialPageRoute materialPageRoute =
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RegisterMTN());
                                Navigator.of(context).push(materialPageRoute);
                              },
                              child: Text(
                                'ลงทะเบียน',
                                style: TextStyle(color: Colors.blue[400]),
                              )),
                          Text('เพื่อรับรหัสสำหรับเจ้าหน้าที่'),
                        ],
                      ),
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
