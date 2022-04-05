import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/maintenance/maintenancePage.dart';
// import 'package:app_bu/screen/graph.dart';
import 'package:app_bu/utility/my_constant.dart';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../graphFlat2.dart';
import 'page_onboarding.dart';
import 'menuBar.dart';

class SplashScreenLoad extends StatefulWidget {
  @override
  _SplashScreenLoadState createState() => _SplashScreenLoadState();
}

class _SplashScreenLoadState extends State<SplashScreenLoad> {
  String idLogin, autoID;
  @override
  void initState() {
    super.initState();
    checkPre();
  }

  // Future<Null> editToken() async {
  //   try {
  //     FirebaseMessaging firebase = FirebaseMessaging();
  //     String token = await firebase.getToken();
  //     print('token =========$token');

  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     // String level = preferences.getString('level');
  //     String idWarning2 = preferences.getString('idWarning');
  //     // autoID = preferences.getString('autoID');
  //     // print('idLogin ===== $idLogin');
  //     // print('autoID===*************-------------== $autoID');

  //     String path =
  //         '${Myconstant().domain}/appkk/editTokenWhereidWarning.php?isAdd=true&id=$idWarning2&token=$token';
  //     await Dio()
  //         .get(path)
  //         .then((value) => print('==========Update Success============'));
  //   } catch (e) {}
  // }

  Future<Null> checkPre() async {
    try {
      FirebaseMessaging firebase = FirebaseMessaging();
      String token = await firebase.getToken();
      print('token =========$token');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String level = preferences.getString('level');
      idLogin = preferences.getString('id');
      autoID = preferences.getString('autoID');
      print('idLogin ===== $idLogin');
      print('autoID===*************-------------== $autoID');

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

      if (autoID != null && autoID.isNotEmpty) {
        String path2 =
            '${Myconstant().domain}/appkk/editTokenWhereAutoID.php?isAdd=true&mtn_autoid=$autoID&token_mtn=$token';
        await Dio().get(path2).then((value) =>
            print('==========Update Success ***********============'));
      }

      if (level != null && level.isNotEmpty) {
        if (level == 'admin') {
          route(Admin());
        } else if (level == 'user') {
          route(Bar());
        } else {
          route(OnBoardingPage());
        }
      } else {
        if (autoID != null) {
          route(MaintenancePage());
        } else {
          route(OnBoardingPage());
        }
      }
    } catch (e) {}
  }

  void route(Widget routeName) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => routeName,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/megaphone.png',
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
