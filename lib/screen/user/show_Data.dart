import 'dart:convert';
import 'dart:io';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'reviewPage.dart';

class ShowIdWarning extends StatefulWidget {
  @override
  _ShowIdWarningState createState() => _ShowIdWarningState();

  final WarningModel warningModel;
  ShowIdWarning({Key key, this.warningModel}) : super(key: key);
}

class _ShowIdWarningState extends State<ShowIdWarning> {
  bool loadStatus = true;
  bool ll;
  String nameForm, nameUser, phone, agency, dateEnd, timeEnd, time, comment;
  String dateTimeWarning, autoID, moreForm;
  String buildForm, floorspp, numRoom;
  String floorsForm;
  String status;
  String path, path2;
  int sTatus = 0;
  WarningModel warningModel;
  bool loadSatus = true;
  bool staus = true; // have data
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();
  RateModel rateModel;
  double valued;
  String rate;
  double r;
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  String id;
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels = List();
  bool loadStatusB = true;
  bool statusB = true;
  String reStr, idLogin, nameser;
  String reStrB;
  double avg, re = 0, sum;
  int sumAvg;
  String sumed;
  double avgB, reB = 0, sumB;
  int sumAvgB;
  String sumedB;
  List<RateModel> rateModelsB = List();
  // ignore: deprecated_member_use
  var items = List<String>();

  @override
  void initState() {
    super.initState();
    showData();
    aboutNotofication();
    showRate();
  }

  Future<Null> showData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');

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
        warningModel = WarningModel.fromJson(map);
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
          case 'review':
            sTatus = 3;

            break;
          default:
        }

        setState(() {
          nameForm = warningModel.nameForm;
          id = warningModel.id;
          dateTimeWarning = warningModel.dateTimeWarning;
          buildForm = warningModel.buildKk;
          floorspp = warningModel.floorsPp;
          numRoom = warningModel.numRoom;
          print("$buildForm");
          floorsForm = warningModel.airForm;
          print('$floorsForm');
          path = warningModel.fileIMG;
          path2 = warningModel.fileIMG2;
          nameUser = warningModel.nameUser;
          phone = warningModel.phone;
          agency = warningModel.agency;
          dateEnd = warningModel.endDate;
          timeEnd = warningModel.timeEnd;
          print('$dateEnd');
          print('$timeEnd');
          rate = warningModel.rate;
          print('...........................................$rate');
          time = warningModel.time;
          autoID = warningModel.mtnAutoID;
          moreForm = warningModel.moreForm;
          comment = warningModel.commentRec;
        });
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

  Future<Null> route(
    Widget routeName,
    WarningModel warningModel,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', warningModel.id);
    preferences.setString('BuildWarning', warningModel.buildForm);
    preferences.setString('idBuilding', warningModel.idBuildForm);
    preferences.setString('build_kk', warningModel.buildKk);
    preferences.setString('floors_pp', warningModel.floorsPp);
    preferences.setString('numRoom', warningModel.numRoom);
    preferences.setString('AutoID', warningModel.mtnAutoID);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Widget showContent() {
    // ignore: unrelated_type_equality_checks
    return status == false
        ? Center(child: Text('ไม่มีรายกา่รแจ้งเหตุขัดข้อง'))
        : showdataW();
  }

  Future<Null> showRate() async {
    String url =
        '${Myconstant().domain}/appkk/getRateWhereidWarning.php?isAdd=true&id=$id';
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
            avg = double.parse('${rateModel.rate}');
            print('=======================================$avg');
          });
        }
      } else {
        staus = false;
      }
    });
  }

  Widget showGrid() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      children: <Widget>[
        // ignore: deprecated_member_use
        Image.network('${Myconstant().domain}$path'),
        if (path2 == null || path2 == '')
          Container()
        else if (path2 != null)
          Image.network('${Myconstant().domain}$path2'),
      ],
    );
  }

  Widget showdataW() {
    // ignore: unnecessary_brace_in_string_interps
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('วันที่แจ้ง : '),
                    if (time == null || time == '')
                      Text('-')
                    else
                      Text('$dateTimeWarning'),
                  ],
                ),
                Row(
                  children: [
                    Text('เวลาที่แจ้ง : '),
                    if (time == null || time == '')
                      Text('-')
                    else
                      Text('$time'),
                  ],
                ),
                MyStyle().sizedBox10(),
                if (sTatus == 3)
                  SmoothStarRating(
                    color: Colors.pink,
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
                        valued = value;
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
                MyStyle().sizedBox20(),
                Container(child: stepindicator()),
                MyStyle().sizedBox20(),
                if (sTatus == 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        'เสร็จสิ้น ${warningModel.endDate}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${warningModel.timeEnd}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 12),
                      ),
                    ],
                  ),
                if (sTatus == 2)
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.purple,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {
                      route(Review(), warningModel);
                    },
                    child: Text(
                      "ให้คะแนน",
                      style:
                          TextStyle(fontFamily: 'Kanit', color: Colors.white),
                    ),
                  ),
                if (sTatus == 2)
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
                MyStyle().sizedBox10(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'ผู้ดำเนินการซ่อมบำรุง: ',
                          style: TextStyle(color: Colors.black),
                        ),
                        if (autoID == null || autoID == '')
                          Text(
                            'รอดำเนินการจากผู้ดูแลระบบ',
                            style: TextStyle(
                              color: Colors.orange,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        else
                          Text(
                            '$autoID',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                MyStyle().sizedBox10(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        MyStyle().sizedBox10(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.shade200,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'ชื่อเหตุขัดข้อง : ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '$nameForm',
                                  style: TextStyle(
                                    color: Colors.red,
                                    // fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        MyStyle().sizedBox10(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.shade200,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'ห้องที่แจ้งเหตุ : ',
                                      style: TextStyle(color: Colors.black),
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
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          Text('ชั้น ${floorspp} ',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          Text('ลำดับห้อง ${numRoom} ',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ],
                                      )
                                    else
                                      Text('${moreForm} ',
                                          style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        MyStyle().sizedBox10(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.shade200,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'เลขครุภัณฑ์ (เครื่องปรับอากาศ) : ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (floorsForm == '' ||
                                    floorsForm == null ||
                                    floorsForm == 'null')
                                  Text(
                                    'ไม่มี',
                                    style: MyStyle().textStyle(),
                                  )
                                else if (floorsForm != '' ||
                                    floorsForm != null ||
                                    floorsForm != 'null')
                                  Text(
                                    'เลขที่ $floorsForm',
                                    style: MyStyle().textStyle(),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // MyStyle().sizedBox10(),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     color: Colors.grey.shade200,
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           'หน่วยงาน : ',
                        //           style: TextStyle(color: Colors.black),
                        //         ),
                        //         if (agency == '' || agency == null)
                        //           Text(
                        //             'ไม่มี',
                        //             style: MyStyle().textStyle(),
                        //           ),
                        //         if (agency != '')
                        //           Text(
                        //             '$agency',
                        //             style: MyStyle().textStyle(),
                        //           )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        MyStyle().sizedBox10(),
                        MyStyle().sizedBox10(),
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
                                      radius: BorderRadius.all(
                                          Radius.circular(16.0)),
                                      padding: const EdgeInsets.all(8.0),
                                      color: Colors.teal[300]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                children: [
                                  if (path == null || path == '')
                                    CircularProgressIndicator()
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
                        MyStyle().sizedBox10(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'ผู้ที่แจ้งเหตุขัดข้อง : ',
                            ),
                            Text(
                              '$nameUser',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stepindicator() => Column(
        children: [
          StepsIndicator(
            unselectedStepBorderSize: 4,
            doneStepWidget: Icon(
              Icons.check_circle,
              size: 20,
              color: Colors.green,
            ),
            selectedStepWidget: Icon(
              Icons.assignment_turned_in,
              size: 30,
              color: Colors.blue,
            ),
            selectedStepSize: 20,
            selectedStepBorderSize: 10,
            selectedStepColorIn: Colors.red,
            selectedStepColorOut: Colors.red,
            doneLineColor: Colors.green,
            lineLength: 80,
            nbSteps: 4,
            selectedStep: sTatus,
          ),
          MyStyle().sizedBox10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('แจ้งเหตุ'),
              Text('กำลังดำเนินการ'),
              Text('ซ่อมเสร็จสิ้น'),
              Text('ให้คะแนน'),
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'รายละเอียดที่แจ้งเหตุขัดข้อง',
          style:
              TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Kanit'),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            loadStatus ? MyStyle().showProgress(Colors.teal) : showContent()
          ],
        ),
      ),
    );
  }
}
