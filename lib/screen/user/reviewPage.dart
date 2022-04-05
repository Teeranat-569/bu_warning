import 'dart:convert';
import 'dart:io';

import 'package:app_bu/models/maintenance_models.dart';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/user/menuBar.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String nameStr, idUser, autoID;
  TextEditingController name = TextEditingController();
  var rating = 0.0;
  double valued;

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

  Future<Null> addRate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');
    // ignore: non_constant_identifier_names
    String build_kk = preferences.getString('build_kk');
    // ignore: non_constant_identifier_names
    String floors_pp = preferences.getString('floors_pp');
    String numRoom = preferences.getString('numRoom');
    String moreForm = preferences.getString('moreForm');

    String url =
        '${Myconstant().domain}/appkk/addRated.php?isAdd=true&idWarning=$idWarning&rate=$valued&comment_rec=$nameStr&build_kk=$build_kk&floors_pp=$floors_pp&numRoom=$numRoom&moreForm=$moreForm';
    try {
      await Dio().get(url).then((value) {});
    } catch (e) {}
  }

  Future<Null> addRatetoWarninglist() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');
    String url =
        '${Myconstant().domain}/appkk/editRateWhereIdWarning.php?isAdd=true&id=$idWarning&rate=$valued&comment_rec=$nameStr';
    try {
      Response response = await Dio().get(url);
      print('======================$response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');
    } catch (e) {}
  }

  Widget nameForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: name,
        cursorColor: Colors.red,
        cursorHeight: 5.0,
        maxLines: 3,
        textAlignVertical: TextAlignVertical(
          y: 0.3,
        ),
        maxLength: 200,
        onChanged: (value) => nameStr = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).pushReplacement(materialPageRoute);
  }

  Future<Null> updateStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');
    String url =
        '${Myconstant().domain}/appkk/editStatusWhereIdWarningRate.php?isAdd=true&id=$idWarning&status=review';
    try {
      Response response = await Dio().get(url);
      print('======================$response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');
      notificationTOadmin('2');
      notificationTOMTN(autoID);
    } catch (e) {}
  }

  Future<Null> notificationTOMTN(String autoID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // idUser = preferences.getString('id');
    autoID = preferences.getString('AutoID');
    print('wwwwwwwwwwwwwwwwwwwwAutoooooIUIIIIIwwwwwww $autoID');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getDataWhereAutoID.php?isAdd=true&mtn_autoID=$autoID';
    await Dio().get(urlFindToken).then((value) {
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        MaintenanceModel models = MaintenanceModel.fromJson(json);
        String tokenMTN = models.tokenMtn;

        String title = 'ผู้ใช้ให้คะแนนความพึงพอใจแล้ว';
        String body = 'เปิดดูได้เลย';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotificationtoMTN.php?isAdd=true&token=$tokenMTN&title=$title&body=$body';
        sendNotificationTOMTN(urlSendToken);
        print('------------------------------------$tokenMTN');
        print('----------------Send Success MTN----------------------------');
      }
    });
  }

  Future<Null> notificationTOadmin(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idUser = preferences.getString('id');
    autoID = preferences.getString('AutoID');
    print('wwwwwwwwwwwwwwwwwwwwwwwwwww $autoID');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getUserWhereidAdmin.php?isAdd=true&id=$idUser';
    await Dio().get(urlFindToken).then((value) {
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        UserModel models = UserModel.fromJson(json);
        String tokenAdmin = models.token;

        String title = 'ผู้ใช้ให้คะแนนความพึงพอใจแล้ว';
        String body = 'เปิดดูได้เลย';

        String urlSendToken2 =
            '${Myconstant().domain}/appkk/apiNotification.php?isAdd=true&token=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOAdmin(urlSendToken2);
        print('------------------------------------$tokenAdmin');
        print('----------------Send Success----------------------------');
      }
    });
  }

  Future<Null> sendNotificationTOAdmin(String urlSendToken2) async {
    await Dio().get(urlSendToken2).then((value) => Fluttertoast.showToast(
          msg: "ส่งไปยังผู้ดูแลระบบสำเร็จ",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange[800],
          textColor: Colors.white,
          fontSize: 16,
        ));
  }

  Future<Null> sendNotificationTOMTN(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "ส่งไปยังฝ่ายซ่อมบำรุงสำเร็จ",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[800],
          textColor: Colors.white,
          fontSize: 16,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('คะแนนการซ่อมบำรุง'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyStyle().sizedBox20(),
                Text('โปรดให้คะแนนการซ่อมบำรุงเพื่อประเมินความพึงพอใจ'),
                SizedBox(height: 50),
                Center(
                    child: SmoothStarRating(
                  borderColor: Colors.deepPurple,
                  color: Colors.pink[900],
                  rating: rating,
                  isReadOnly: false,
                  size: 55,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing: 2.0,
                  onRated: (value) {
                    setState(() {
                      valued = value;
                      print("rating value -> $value");
                    });
                  },
                )),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'ข้อเสนอแนะ : ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                nameForm(),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.purple[900],
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    addRate();
                    addRatetoWarninglist();
                    // ignore: unnecessary_brace_in_string_interps
                    print('Send_Rate${valued}');
                    route(Bar());
                    updateStatus();
                    Fluttertoast.showToast(
                      msg: "ให้คะแนนสำเร็จ",
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.pink[200],
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  },
                  child: Text(
                    'ส่งคะแนน',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
