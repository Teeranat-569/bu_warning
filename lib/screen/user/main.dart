import 'dart:io';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/user/login.dart';
import 'package:app_bu/screen/user/warningForm.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imagebutton/imagebutton.dart';

class ShowlistMain extends StatefulWidget {
  final UserModel usermodel;
  ShowlistMain({Key key, this.usermodel}) : super(key: key);

  @override
  _ShowlistMainState createState() => _ShowlistMainState();
}

class _ShowlistMainState extends State<ShowlistMain> {
  final textForm = GlobalKey<FormState>();
  String nameUser;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    findUser();
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

  // Future<Null> signout() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.clear();
  //   route(Authen());
  // }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name'); //
    });
  }

  Widget showAlertIMG() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        color: Colors.teal.shade200,
      ),
      child: Column(
        children: [
          ImageButton(
            children: <Widget>[],
            width: 250,
            height: 250,
            paddingTop: 5,
            pressedImage: Image.asset(
              "images/scalable.png",
            ),
            unpressedImage: Image.asset("images/scalable.png"),
            onTap: () {
              print('test');
              route(Showlist1());
            },
          ),
          SizedBox(
            height: 5,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     'แจ้งเหตุที่นี่',
          //     style: TextStyle(
          //       fontSize: 36.0,
          //       fontFamily: 'Kanit',
          //       color: Colors.pink[900],
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<Null> route(Widget routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('id');
    print('pre >>>>>>>> $preferences');
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Widget showText() {
    return Center(
        child: Text(
      'ยินดีต้อนรับ',
      style: TextStyle(
        fontSize: 36.0,
        fontFamily: 'Kanit',
      ),
    ));
  }

  Widget showText2() {
    return Center(
        child: Text(
      'ระบบแจ้งเหตุขัดข้องภายในอาคาร',
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Kanit',
      ),
    ));
  }

  Widget showText3() {
    return Center(
        child: Text(
      'บริเวณมหาวิทยาลัยราชภัฏบ้านสมเด็จเจ้าพระยา',
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: 'Kanit',
      ),
    ));
  }

  Future<Null> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Authen());
    Navigator.of(context).pushReplacement(materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          key: textForm,
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nameUser == null
                                      ? 'หน้าหลัก'
                                      : '$nameUser Login',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showText(),
              showText2(),
              showText3(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    showAlertIMG(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
