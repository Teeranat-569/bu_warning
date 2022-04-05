import 'dart:convert';
import 'dart:io';
import 'package:app_bu/models/cateBuilding_model.dart';
import 'package:app_bu/screen/admin/autoSearchUser.dart';
import 'package:app_bu/screen/admin/deleteBuildingPage.dart';
import 'package:app_bu/screen/admin/statusBar_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../user/login.dart';
import 'addBuildingPage.dart';
import 'autoSearchBuildingAdmin.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool loadStatus = true;
  bool status = true;
  List<CateBuildingModel> catebuildingModels = List();
  CateBuildingModel cateBuildingModel;
  @override
  void initState() {
    super.initState();
    aboutNotofication();
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
    } catch (e) {}
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

  Future<Null> getAllhousePP() async {
    String url = '${Myconstant().domain}/appkk/getAllhousePP.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          setState(() {
            cateBuildingModel = CateBuildingModel.fromJson(map);

            catebuildingModels.add(cateBuildingModel);
            // filterBuildingModels = buildingModels;
            // name = buildingModel.buildingName;
          });
        }
      } else {
        status = false;
      }
    });
  }

//ออกจากระบบสู่หน้า Login
  Future<Null> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // MaterialPageRoute materialPageRoute =
    //     MaterialPageRoute(builder: (BuildContext context) => Authen());
    // Navigator.of(context).pushReplacement(materialPageRoute);

    Navigator.of(context)
    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

//ปุ่มไปยังรายการแจ้งเหตุ
  Widget listButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.deepOrange.shade50,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Listdata());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Column(
        children: [
          Icon(
            Icons.list_alt,
            size: 36,
          ),
          Text(
            'รายการแจ้งเหตุ',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

//ปุ่มสถิติความพึงพอใจ
  Widget graphScore() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.deepOrange.shade50,
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AutoCompleteDemoBuildingAdmin());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Column(
        children: [
          Icon(
            Icons.star_half,
            size: 36,
          ),
          Text(
            'สถิติความพึงพอใจ',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

//ปุ่มข้อมูลผู้ใช้
  Widget searchUser() {
    // ignore: deprecated_member_use
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.deepOrange.shade50,
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AutoCompleteDemoUser());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Column(
        children: [
          Icon(
            Icons.people,
            size: 36,
          ),
          Text(
            'ข้อมูลผู้ใช้',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
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
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AddBuildingPage());
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

  Future<Null> route(
      Widget routeName, CateBuildingModel cateBuildingModel) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

//ลบสถานที่
  Widget deleteBuilding() {
    // ignore: deprecated_member_use
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.red.shade600,
      onPressed: () {
        route(DelBuildingPage(), cateBuildingModel);
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
      child: Image.asset('images/settings.png'),
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
        toolbarHeight: 40,
        backgroundColor: Colors.deepOrange.shade600,
        title: Text(
          'ฝ่ายผู้ดูแลระบบ',
          style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
        ),
        actions: <Widget>[
          signoutButton(),
        ],
      ),
      body: Container(
        color: Colors.deepOrange.shade600,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListView(
              children: [
                SizedBox(
                  height: 40.0,
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: addBuild(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: deleteBuilding(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: searchUser(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: listButton(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: graphScore(),
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
