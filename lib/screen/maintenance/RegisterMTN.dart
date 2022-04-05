import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/maintenance/show_autoID.dart';
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

class RegisterMTN extends StatefulWidget {
  @override
  _RegisterMTNState createState() => _RegisterMTNState();
}

class _RegisterMTNState extends State<RegisterMTN> {
//Explicit
  final textFill = GlobalKey<FormState>();
  String nameStr, lastNameStr, passwordStr, moreStr, _chosenValue, phoneStr;
  String chooseRadio;
  String chooseRadio2;
  String idLogin;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  Response response;
  ProgressDialog pr;
  String autoID;
  int i;
  Random random;

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
    random = Random();
    i = random.nextInt(1000);

    String url =
        '${Myconstant().domain}/appkk/addMTN.php?isAdd=true&mtn_autoID=0&mtn_name=$nameStr&mtn_lastname=$lastNameStr&password=$passwordStr&mtn_phone=$phoneStr&gender=$_chosenValue&token_mtn=$token';
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
    idLogin = preferences.getString('id');

    String url =
        '${Myconstant().domain}/appkk/getWhereStudent_id.php?isAdd=true&student_id=$lastNameStr';
    try {
      String path =
          '${Myconstant().domain}/appkk/editTokenWhereId.php?isAdd=true&student_id=$lastNameStr&token=$token';
      print('idLogin ===== $lastNameStr');
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
              MyStyle().showProgress(Colors.blue);
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
              MyStyle().showProgress(Colors.blue);
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
            // toastLength: Toast.LENGTH_SHORT,
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
        color: Colors.blue.shade900,
        child: Text('ลงทะเบียน',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        onPressed: () {
          print(
              '-------------------------------------------------------------------------${response.toString()}');
          print(
              'name = $nameStr, รหัสนักศึกษา = $lastNameStr, password = $passwordStr, gender = $chooseRadio , level = user');
          if (nameStr == null ||
              nameStr.isEmpty ||
              lastNameStr == null ||
              lastNameStr.isEmpty ||
              passwordStr == null ||
              passwordStr.isEmpty) {
            myAlert('มีช่องว่าง', 'กรุณากรอกข้อมูลให้ครบ');
          } else if (_chosenValue == null) {
            myAlert('โปรดเลือกตัวเลือก', 'คุณไม่ได้เลือกเพศ');
          } else if (phoneStr == null) {
            myAlert('มีช่องว่าง', 'กรุณากรอกเบอร์โทรศัพท์');
          } else {
            getAllUser();
          }
        });
  }

  Future<void> routeRemove(Widget routeName) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('id', maintenanceModel.idMtn);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => routeName,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> getAllUser() async {
    String url =
        '${Myconstant().domain}/appkk/getUserWhereUserMTN.php?isAdd=true&mtn_name=$nameStr';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        print('value >>>>>>>>${value.toString()}');
        print('**********************$value');
        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');
        showAlert("คำเตือน", 'รหัสนักศึกษาหรือชื่อผู้ใช้ $nameStr มีอยู่แล้ว ');
      } else {
        registerThread();
        routeRemove(ShowAutoID(
          mtn_name: textEditingController.text,
          mtn_lastname: textEditingController2.text,
          phone_mtn: textEditingController5.text,
          password: textEditingController3.text,
          gender: _chosenValue,
        ));
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
        prefixIcon: Icon(
          Icons.badge,
          color: Colors.blue,
        ),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelText: 'ชื่อจริง',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget lastNameForm() {
    return TextFormField(
      controller: textEditingController2,
      onChanged: (value) => lastNameStr = value.trim(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.badge,
          color: Colors.blue,
        ),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelText: 'นามสกุลจริง',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget phoneForm() {
    return TextFormField(
      controller: textEditingController5,
      onChanged: (value) => phoneStr = value.trim(),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.blue,
        ),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelText: 'เบอร์โทรศัพท์',
        labelStyle: TextStyle(
          color: Colors.grey,
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
        prefixIcon: Icon(
          Icons.password,
          color: Colors.blue,
        ),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelText: 'รหัสผ่าน',
        labelStyle: TextStyle(
          color: Colors.grey,
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
            color: Colors.black, fontSize: 14,
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
            color: Colors.blue[100],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        title: Text(
          'ลงทะเบียน',
          style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Colors.blue[50],
        child: Form(
          key: textFill,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              nameForm(),
              SizedBox(
                height: 10,
              ),
              lastNameForm(),
              SizedBox(
                height: 10,
              ),
              passwordForm(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  dropDown(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              phoneForm(),
              SizedBox(
                height: 10,
              ),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
