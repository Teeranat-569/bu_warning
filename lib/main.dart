import 'package:app_bu/screen/admin/adminPage.dart';
import 'package:app_bu/screen/admin/delete_Buildings.dart';
import 'package:app_bu/screen/maintenance/login_mtn.dart';
import 'package:app_bu/screen/user/menuBar.dart';

// import 'package:app_bu/screen/graph.dart';
import 'package:app_bu/screen/user/splashscreen.dart';
import 'package:app_bu/screen/user/splashscreenLoad.dart';
import 'package:app_bu/screen/user/success_send..dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import 'screen/user/login.dart';
import 'screen/user/page_onboarding.dart';
// import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

void main() {
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  runApp(Appbu());
}

class Appbu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashScreen(),
          '/login': (BuildContext context) => Authen(),
          '/loginMTN': (BuildContext context) => Login_Mtn(),
          '/send': (BuildContext context) => SuccessSend(),
          '/bar': (BuildContext context) => Bar(),
          '/loadCheck': (BuildContext context) => SplashScreenLoad(),
          '/on': (BuildContext context) => OnBoardingPage(),
          '/screen1': (BuildContext context) => Admin(),
          '/screen4': (BuildContext context) => Delete(),
        },
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Sarabun',
        ),
      ),
    );
  }
}
