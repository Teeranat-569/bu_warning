import 'dart:convert';
import 'dart:io';
import 'package:app_bu/models/maintenance_models.dart';
import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/admin/changeMTN.dart';
import 'package:app_bu/screen/admin/statusBar_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ShowIdWarning extends StatefulWidget {
  @override
  _ShowIdWarningState createState() => _ShowIdWarningState();

  final WarningModel warningModel;
  final String chMTN;
  ShowIdWarning({Key key, this.warningModel, this.chMTN}) : super(key: key);
}

class _ShowIdWarningState extends State<ShowIdWarning> {
  bool loadStatus = true;
  bool loadStatus2 = true;
  bool status5 = true;
  bool status2, valued;
  String nameForm,
      agency,
      phone,
      time,
      rate,
      autoID,
      nameMTN,
      timeEnd,
      dateEnd,
      comment;
  String dateTimeWarning, floorspp, numRoom, moreForm;
  String idWarning;
  String buildForm;
  String airForm;
  String status;
  String path, path2;
  String nameUser;
  String chooseStatus;
  String dateTimeWarningEnd;
  int sTatus = 0;
  String timeWarning;
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  // ignore: deprecated_member_use
  List<MaintenanceModel> mainModels = List();
  double avg, avg2;
  String selected;
  // ignore: deprecated_member_use
  List data = List();

  @override
  void initState() {
    super.initState();
    showData();
    showRate();
    getAllMTN();
    getAllMTN2();
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
        print('******************************Noti OnLunch');
        // ignore: missing_return
      }, onResume: (message) {
        print('Noti OnResume ข้อความจากหน้า Home ${message.toString()}');
        // ignore: missing_return
      }, onMessage: (message) {
        print('Noti OnMessage เปิดหน้าของแอพอยู่');
        showSimpleNotification(
          Column(
            children: [
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

  Future getAllMTN() async {
    var response = await http.get("${Myconstant().domain}/appkk/getAllMTN.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });

    print(jsonData);
  }

  Future<Null> showData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idWarning = preferences.getString('idWarning');

    String url =
        '${Myconstant().domain}/appkk/getDataWhereidWarning.php?isAdd=true&id=$idWarning';
    try {
      Response response = await Dio().get(url);

      setState(() {
        loadStatus = false;
      });
      print('res >>>>>>>>> $response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');

      for (var map in result) {
        WarningModel warningModel = WarningModel.fromJson(map);
        print(warningModel);

        switch (warningModel.status) {
          case 'UserWarning':
            sTatus = 0;
            break;
          case 'Fix':
            sTatus = 1;
            break;
          case 'FInish':
            sTatus = 2;
            break;
          default:
        }

        setState(() {
          nameForm = warningModel.nameForm;
          dateTimeWarning = warningModel.dateTimeWarning;
          time = warningModel.time;
          // buildForm = warningModel.buildForm;
          airForm = warningModel.airForm;
          path = warningModel.fileIMG;
          buildForm = warningModel.buildKk;
          floorspp = warningModel.floorsPp;
          numRoom = warningModel.numRoom;
          path2 = warningModel.fileIMG2;
          nameUser = warningModel.nameUser;
          agency = warningModel.agency;
          phone = warningModel.phone;
          status = warningModel.status;
          rate = warningModel.rate;
          autoID = warningModel.mtnAutoID;
          timeEnd = warningModel.timeEnd;
          dateEnd = warningModel.endDate;
          moreForm = warningModel.moreForm;
          comment = warningModel.commentRec;
          print('gggggggggggggggggggggggggggggggggggggggggg $autoID');
        });
        String url2 =
            '${Myconstant().domain}/appkk/getDataWhereAutoID.php?isAdd=true&mtn_autoID=$autoID';
        Response response2 = await Dio().get(url2);

        setState(() {
          loadStatus2 = false;
        });
        print('res >>>>>>>>> $response2');
        var result2 = json.decode(response2.data);
        print('result >>>>>>>>> $result2');
        for (var map2 in result2) {
          setState(() {
            MaintenanceModel warningModel = MaintenanceModel.fromJson(map2);
            mainModels.add(warningModel);
            nameMTN = warningModel.mtnName;
            print(warningModel);
            print('5555555555555555555555555555555$nameMTN');
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> updateStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');
    DateTime time = DateTime.now();
    DateTime dateTime = DateTime.now();
    timeWarning = DateFormat('HH:mm').format(time);

    dateTimeWarningEnd = DateFormat.yMMMMEEEEd().format(dateTime);

    String url =
        '${Myconstant().domain}/appkk/editStatusWhereidWarning.php?isAdd=true&id=$idWarning&status=$chooseStatus&end_date=$dateTimeWarningEnd&time_end=$timeWarning';

    try {
      Response response = await Dio().get(url);
      print('======================$response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');

      print('5555555555555555555555555555555555555555555555555555555555555' +
          dateTimeWarningEnd);

      if (chooseStatus == 'Fix') {
        notificationTOuserFIX(idWarning);
        Fluttertoast.showToast(
          msg: "เลือกสถานะ กำลังดำเนินการ",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange[200],
          textColor: Colors.black,
          fontSize: 16,
        );
      } else if (chooseStatus == 'FInish') {
        notificationTOuserFINISH(idWarning);
        Fluttertoast.showToast(
          msg: "เลือกสถานะ เสร็จสิ้น",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange[200],
          textColor: Colors.black,
          fontSize: 16,
        );

        print(dateTimeWarningEnd);
      }
    } catch (e) {}
  }

  Future<Null> notificationTOuserFIX(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idWarning = preferences.getString('idWarning');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getDataWhereidWarning.php?isAdd=true&id=$idWarning';
    await Dio().get(urlFindToken).then((value) {
      print('-----------------------------$value');
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        WarningModel models = WarningModel.fromJson(json);
        String tokenAdmin = models.token;
        avg2 = double.parse(models.rate);
        String title = 'กำลังดำเนินการ';
        String body = 'ฝ่ายซ่อมบำรุงกำลังเข้าซ่อมบำรุง';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotificationFIX.php?isAdd=true&token=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOuser(urlSendToken);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> notificationTOuserForScore(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idWarning = preferences.getString('idWarning');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getDataWhereidWarning.php?isAdd=true&id=$idWarning';
    await Dio().get(urlFindToken).then((value) {
      print('-----------------------------$value');
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        WarningModel models = WarningModel.fromJson(json);
        String tokenAdmin = models.token;
        avg2 = double.parse(models.rate);
        String title = 'ซ่อมแซมสำเร็จแล้ว';
        String body = 'ให้คะแนนความพึงพอใจได้เลย...';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotificationForScore.php?isAdd=true&token=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOuser(urlSendToken);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> notificationTOMTN(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idWarning = preferences.getString('idWarning');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getDataWhereAutoID.php?isAdd=true&mtn_autoID=$selected';
    await Dio().get(urlFindToken).then((value) {
      print('-----------------------------$value');
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        MaintenanceModel models = MaintenanceModel.fromJson(json);
        String tokenAdmin = models.tokenMtn;
        // avg2 = double.parse(models.rate);
        String title = 'มีเหตุขัดข้องเข้ามาใหม่';
        String body = 'สามารถดูได้ตอนนี้เลย...';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotificationtoMTN.php?isAdd=true&token_mtn=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOMTN(urlSendToken);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> getDatawhereautoID() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereAutoID.php?isAdd=true&mtn_autoID=$autoID';
    print('pppppppppppppppppppppppppppp $autoID');
    try {
      Response response = await Dio().get(url);

      setState(() {
        loadStatus = false;
      });
      print('res >>>>>>>>> $response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');

      for (var map in result) {
        setState(() {
          MaintenanceModel warningModel = MaintenanceModel.fromJson(map);
          mainModels.add(warningModel);
          nameMTN = warningModel.mtnName;
          print(warningModel);
          print('5555555555555555555555555555555$nameMTN');
        });
      }
    } catch (e) {}
    // }//
//
  }

  Future<Null> sendToMTN() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');

    String url =
        '${Myconstant().domain}/appkk/editDataWhereIdWarning.php?isAdd=true&id=$idWarning&mtn_autoID=$selected';

    try {
      Response response = await Dio().get(url);
      print('======================$response');
      var result = json.decode(response.data);
      print('result >>>>>>>>> $result');

      print('5555555555555555555555555555555555555555555555555555555555555' +
          selected);

      // if (chooseStatus == 'Fix') {
      notificationTOMTN(idWarning);
      Fluttertoast.showToast(
        msg: "เลือกผู้รับดำเนินการสำเร็จ",
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange[200],
        textColor: Colors.black,
        fontSize: 16,
      );
    } catch (e) {}
  }

  Future<Null> showRate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String idUser = preferences.getString('id');
    String idWarning = preferences.getString('idWarning');
    String url =
        '${Myconstant().domain}/appkk/getRateWhereidWarning.php?isAdd=true&idWarning=$idWarning';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          RateModel rateModel = RateModel.fromJson(map);
          setState(() {
            rateModels.add(rateModel);
            avg = double.parse('${rateModel.rate}');
            print('=======================================$avg');
          });
        }
      } else {
        status2 = false;
      }
    });
  }

  Future<Null> notificationTOuserFINISH(String idUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idWarning = preferences.getString('idWarning');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getDataWhereidWarning.php?isAdd=true&id=$idWarning';
    await Dio().get(urlFindToken).then((value) {
      print('-----------------------------$value');
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        WarningModel models = WarningModel.fromJson(json);
        String tokenAdmin = models.token;
        print('oooooooooooooooooooooooooooooooooooooooooooooo$tokenAdmin');

        String title = 'ดำเนินการเสร็จสิ้น';
        String body = 'โปรดให้คะแนนความพึงพอใจ';
        String urlSendToken2 =
            '${Myconstant().domain}/appkk/apiNotificationFInish.php?isAdd=true&token=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOuser(urlSendToken2);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> sendNotificationTOuser(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "แจ้งผู้ใช้สำเร็จ",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        ));
  }

  Future<Null> sendNotificationTOMTN(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "แจ้งสำเร็จ",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        ));
  }

  Widget showContent() {
    // ignore: unrelated_type_equality_checks
    return status == false
        ? Center(child: Text('ไม่มีรายกา่รแจ้งเหตุขัดข้อง'))
        : showdataW();
  }

  Widget showContentAIR() {
    return airForm == ''
        ? Text(
            'ไม่มี',
            style: TextStyle(color: Colors.red),
          )
        : Text(
            'เลขที่ $airForm',
            style: TextStyle(color: Colors.red),
          );
  }

  Future<Null> getAllMTN2() async {
    String url = '${Myconstant().domain}/appkk/getAllMTN.php';
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
            mainModels.add(maintenanceModel);
          });
        }
      } else {
        status5 = false;
      }
    });
  }

  Widget showdataW() {
    // ignore: unnecessary_brace_in_string_interps
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(00.0),
          color: Colors.orange[400],
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (status == 'review')
                  Column(
                    children: [
                      SmoothStarRating(
                        color: Colors.orange[800],
                        borderColor: Colors.amber,
                        rating: double.parse(rate),
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          setState(() {
                            valued = value as bool;
                            print("rating value -> $value");
                          });
                        },
                      ),
                      if (comment == null || comment == '')
                        Row(
                          children: [],
                        )
                      else
                        Text('comment : $comment'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Text(
                            'เสร็จสิ้น $dateEnd',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$timeEnd',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'ผู้ดำเนินการ',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '$autoID $nameMTN',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                if (status == 'UserWarning')
                  if (autoID == null || autoID == '')
                    Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.deepOrange),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      'ผู้ดำเนินการ',
                                      style: TextStyle(
                                          fontFamily: 'Kanit',
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  )),
                              SizedBox(
                                width: 10.0,
                              ),
                              DropdownButton(
                                value: selected,
                                hint: Text('เลือกผู้ดำเนินการ'),
                                items: data.map((list) {
                                  return DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        Text(list['mtn_autoID']),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(list['mtn_name']),
                                      ],
                                    ),
                                    value: list['mtn_autoID'].toString(),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selected = value;
                                    print('555555555555555555' + value);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              RaisedButton(
                                color: Colors.purple,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                                child: Text(
                                  'เลือกผู้ดำเนินการ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // updateStatus();
                                  MaterialPageRoute materialPageRoute =
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Listdata());
                                  Navigator.of(context)
                                      .pushReplacement(materialPageRoute);
                                  sendToMTN();
                                  print('22222222222222222222');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ])
                  else
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'ผู้ดำเนินการ',
                                        style: TextStyle(
                                            fontFamily: 'Kanit', fontSize: 20),
                                      ),
                                      Text(
                                        '$autoID $nameMTN',
                                        style: TextStyle(
                                            fontFamily: 'Kanit', fontSize: 20),
                                      ),
                                      RaisedButton(
                                        color: Colors.purple,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    20.0)),
                                        onPressed: () {
                                          MaterialPageRoute materialPageRoute =
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ChangeMTN());
                                          Navigator.of(context)
                                              .pushReplacement(materialPageRoute);
                                        },
                                        child: Text(
                                          'เปลี่ยนผู้ดำเนินการ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                if (status == 'Fix')
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'ผู้ดำเนินการ',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 20),
                                    ),
                                    Text(
                                      '$autoID $nameMTN',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 20),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                if (status == 'FInish')
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.yellow[600],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'รอการให้คะแนนความพึงพอใจจากผู้ใช้งาน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Kanit',
                                    color: Colors.black),
                              ),
                              Text(
                                'โปรดตรวจสอบที่สถานะ "รีวิว"',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Kanit',
                                    color: Colors.black),
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                color: Colors.yellow[200],
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                                child: Text(
                                  'แจ้งเตือนผู้ใช้งาน',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  notificationTOuserForScore(idWarning);
                                  Fluttertoast.showToast(
                                    msg: "แจ้งเตือนผู้ใช้งาน",
                                    // toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.orange[200],
                                    textColor: Colors.black,
                                    fontSize: 16,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Text(
                            'เสร็จสิ้น ${dateEnd}',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${timeEnd}',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'ผู้ดำเนินการ',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '$autoID $nameMTN',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                sizedBox10(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'วันที่แจ้งเหตุ >>> ',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            // color: Colors.grey
                          ),
                        ),
                        Text(
                          '$dateTimeWarning',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            // color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    sizedBox10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'เวลาแจ้งเหตุ >>> ',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            // color: Colors.grey
                          ),
                        ),
                        Text(
                          '$time',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            // color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    sizedBox10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('ผู้ที่แจ้งเหตุขัดข้อง : '),
                            Text(
                              '$nameUser',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizedBox10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('เบอร์โทรติดต่อ : '),
                            Row(
                              children: [
                                Text(
                                  '$phone',
                                  style: TextStyle(color: Colors.green),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.phone_enabled,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      if (await canLaunch('tel:$phone')) {
                                        await launch('tel:$phone');
                                      } else {
                                        throw 'Couid not launch $phone';
                                      }
                                    })
                              ],
                            ),
                          ]),
                    ),
                    sizedBox10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ชื่อเหตุขัดข้อง : ',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$nameForm',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizedBox10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ห้องที่แจ้งเหตุ : ',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (moreForm == null || moreForm == '')
                                  Row(
                                    children: [
                                      Text('อาคาร ${buildForm} ',
                                          style: TextStyle(color: Colors.red)),
                                      Text('ชั้น ${floorspp} ',
                                          style: TextStyle(color: Colors.red)),
                                      Text('ลำดับห้อง ${numRoom} ',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  )
                                else
                                  Text('${moreForm} ',
                                      style: TextStyle(color: Colors.red)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    sizedBox10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'เลขครุภัณฑ์ (เครื่องปรับอากาศ) : ',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            showContentAIR(),
                          ],
                        ),
                      ),
                    ),
                    sizedBox20(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          child: SizedBox(
                            height: 56,
                            child: TabBar(
                              labelColor: Colors.red,
                              tabs: [
                                Text('รูปภาพที่ 1',
                                    style: TextStyle(color: Colors.black)),
                                Text('รูปภาพที่ 2',
                                    style: TextStyle(color: Colors.black)),
                              ],
                              indicator: ContainerTabIndicator(
                                  radius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  padding: const EdgeInsets.all(8.0),
                                  color: Colors.orange[300]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                            children: [
                              if (path == null || path == '')
                                LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: Colors.amber,
                                  minHeight: 10,
                                )
                              else if (path != null)
                                ClipRect(
                                  child: InteractiveViewer(
                                    maxScale: 20,
                                    child: Image.network(
                                        '${Myconstant().domain}$path'),
                                  ),
                                ),
                              if (path2 == null || path2 == '')
                                Container(
                                  child: Center(
                                      child: Text(
                                    'ไม่มีรูปภาพ',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                )
                              else if (path2 != null)
                                ClipRect(
                                  child: InteractiveViewer(
                                    maxScale: 20,
                                    child: Image.network(
                                        '${Myconstant().domain}$path2'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBox20(),
                    sizedBox10(),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  SizedBox sizedBox20() {
    return SizedBox(
      height: 15.0,
    );
  }

  SizedBox sizedBox10() {
    return SizedBox(
      height: 10.0,
    );
  }

  TextStyle textStyle() => TextStyle(color: Colors.red, fontSize: 16);
  TextStyle textStyled() => TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดการแจ้งเหตุ',
          style: TextStyle(
            fontFamily: 'Kanit',
          ),
        ),
        toolbarHeight: 40,
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            loadStatus
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber,
                  ))
                : showContent()
          ],
        ),
      ),
    );
  }
}
