import 'dart:convert';
import 'dart:io';

import 'package:app_bu/models/maintenance_models.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataMTN extends StatefulWidget {
  @override
  _UserDataMTNState createState() => _UserDataMTNState();
}

class _UserDataMTNState extends State<UserDataMTN> {
  String name, lastname, token, phone, autoID, gender;
  bool loadStatus = true;
  bool status = true;
  List<MaintenanceModel> maintenanceModels = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showDataUSERWARNING();
    aboutNotofication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.blue,
      ),
      body: loadStatus
          ? Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loading . . . .',
                        style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
                      ),
                      LinearProgressIndicator(
                        minHeight: 20,
                        color: Colors.white,
                        backgroundColor: Colors.blue[100],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue[200],
                          ),
                          child:
                              // Text('${name}'),
                              Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'รหัสสำหรับเจ้าหน้าที่',
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${autoID}',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 20),
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ชื่อ ',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                          ),
                          if (name == null)
                            LinearProgressIndicator(
                              color: Colors.blue,
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${name}',
                                  style: TextStyle(
                                      fontFamily: 'Kanit', fontSize: 16),
                                ),
                              ),
                            ),
                          Text(
                            'นามสกุล',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                          ),
                          if (lastname == null)
                            LinearProgressIndicator(
                              color: Colors.blue,
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${lastname}',
                                  style: TextStyle(
                                      fontFamily: 'Kanit', fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'เพศ',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                          ),
                          if (gender == null)
                            LinearProgressIndicator(
                              color: Colors.blue,
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${gender}',
                                  style: TextStyle(
                                      fontFamily: 'Kanit', fontSize: 16),
                                ),
                              ),
                            ),
                          Text(
                            'เบอร์โทร',
                            style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                          ),
                          if (phone == null)
                            LinearProgressIndicator(
                              color: Colors.blue,
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${phone}',
                                  style: TextStyle(
                                      fontFamily: 'Kanit', fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
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

  Future<Null> showDataUSERWARNING() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('autoID');

    String url =
        '${Myconstant().domain}/appkk/getUserWhereAutoIDMTN.php?isAdd=true&mtn_autoID=$idUser';
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
            MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
            maintenanceModels.add(maintenanceModel);
            name = maintenanceModel.mtnName;
            print('/////////////////////////////$name');
            autoID = maintenanceModel.mtnAutoID;
            print('*****************************************$autoID');
            lastname = maintenanceModel.mtnLastname;
            print('*********************************ffffffff********$lastname');
            gender = maintenanceModel.gender;
            print(
                '*****************************ssssssssssssssss************$gender');
            phone = maintenanceModel.mtnPhone;
            print('*********************zzzzzzzzz********************$phone');
          });
        }
      } else {
        status = false;
      }
    });
  }
}
