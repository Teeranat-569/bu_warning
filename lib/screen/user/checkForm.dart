import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

// ignore: must_be_immutable
class CheckForm extends StatefulWidget {
  String buildingg,
      nameFormm,
      airFormm,
      phonee,
      idBuildingg,
      buildingNamee,
      floorss,
      roomss,
      moreFormm;
  File file1, file2;
  CheckForm(
      {Key key,
      this.nameFormm,
      this.buildingg,
      this.airFormm,
      this.file1,
      this.file2,
      this.phonee,
      this.idBuildingg,
      this.buildingNamee,
      this.floorss,
      this.roomss,
      this.moreFormm})
      : super(key: key);
  @override
  _CheckFormState createState() => _CheckFormState();
}

class _CheckFormState extends State<CheckForm> {
  // TabController controller;
  String idUser;
  var formatdate;

  Widget showContent() {
    return widget.airFormm == null || widget.airFormm == ''
        ? Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                'ไม่มี',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        : Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Text(widget.airFormm,
                    style: TextStyle(color: Colors.red))));
  }

  Future<Null> uploadPIC() async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    String urlUpload = '${Myconstant().domain}/appkk/saveFile.php';

    Random random = Random();
    Random random2 = Random();
    int i = random.nextInt(100000);
    int h = random2.nextInt(100000);
    String nameIMG = 'BU$i.jpg';
    String nameIMG2 = 'BU2_$h.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(widget.file1.path, filename: nameIMG);
      map['file2'] =
          await MultipartFile.fromFile(widget.file2.path, filename: nameIMG2);
      FormData formdata = FormData.fromMap(map);
      await Dio().post(urlUpload, data: formdata).then((value) async {
        String urlPathPIC = '/appkk/warninglist/$nameIMG';
        String urlPathPIC2 = '/appkk/warninglist/$nameIMG2';
        print('Upload >>>>>>>> ${Myconstant().domain}$urlPathPIC');
        print('Upload >>>>>>>> ${Myconstant().domain}$urlPathPIC2');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        idUser = preferences.getString('id');
        String nameUser = preferences.getString('name');

        DateTime dateTime = DateTime.now();
        var dateTimeWarning = DateFormat.yMMMMEEEEd();
        formatdate = dateTimeWarning.formatInBuddhistCalendarThai(dateTime);
        print(dateTimeWarning);
        print(
            '//////////////////////////////////////////////////////////////////' +
                formatdate);

        DateTime time = DateTime.now();
        String timeWarning = DateFormat('HH:mm').format(time);

        String urlInsert =
            '${Myconstant().domain}/appkk/addList.php?isAdd=true&DateTime_warning=$formatdate&time=$timeWarning&idUser=$idUser&nameUser=$nameUser&nameForm=${widget.nameFormm}&build_kk=${widget.buildingNamee}&floors_pp=${widget.floorss}&numRoom=${widget.roomss}&moreForm=${widget.moreFormm}&airForm=${widget.airFormm}&phone=${widget.phonee}&fileIMG=$urlPathPIC&fileIMG2=$urlPathPIC2&status=UserWarning&token=$token&end_date=NO Date&time_end=NO time';
        // appkk/addList.php?isAdd=true&DateTime_warning=$dateTimeWarning&time=$timeWarning&idUser=$idUser&nameUsernameUser&nameForm=$nameForm&buildForm=widget.idHolder&build_kk=$select_Building&floors_pp=$select_floors&numRoom_oo=$select_numRoom&airForm=$airProduct&agency=$agency&phone=$phone&fileIMG=$urlPathPIC&status=UserWarning&token=$token';
        await Dio().get(urlInsert).then((value) {
          print('---------------------Succccessssssss---------------------');
        });
      });
    } catch (e) {}
  }

  Future<Null> notificationTOadmin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idUser = preferences.getString('id');
    String urlFindToken =
        '${Myconstant().domain}/appkk/getUserWhereidAdmin.php?isAdd=true&id=2';
    await Dio().get(urlFindToken).then((value) {
      var result = json.decode(value.data);
      print('result =======$result');
      for (var json in result) {
        UserModel models = UserModel.fromJson(json);
        String tokenAdmin = models.token;

        String title = 'มีการแจ้งเหตุขัดข้อง';
        String body = 'รายละเอียดการแจ้งขัดข้องอยู่ในนี้แล้ว';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotification.php?isAdd=true&token=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOAdmin(urlSendToken);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> sendNotificationTOAdmin(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "ส่งไปยังผู้ดูแลระบบสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange[800],
          textColor: Colors.white,
          fontSize: 16,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('eeeeeeeeeeeeeeeeeeeeeeeesssssssssseeeeeee ${widget.airFormm}');
          print(
              'eeeeeeeeeeeeeeeeeeeeffffffffffffffffeeeeeeeeeee ${widget.buildingNamee}');
          print(
              'eeeeeeeeeeeeeeeeeeeeeeeeeeeewwwwwwwwwwweeeeeeeeeeeee ${widget.floorss}');
          print(
              'eeeeeeeeeeeeeeeeeeeffffffffffwwwwwwwwwwwwwwwwwweeeeeeeeeeee ${widget.roomss}');
          print(
              'eeeeeeeeeeeeeeeeeeeeeeeeeeeeee44444444444rrrrrrreeeeeeeeeeee ${widget.phonee}');
          print(
              'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeewwwwwwwwwwrrrrrrrrrreeeee ${widget.moreFormm}');
          uploadPIC();
          notificationTOadmin();
          Navigator.of(context).pushReplacementNamed('/send');
          Fluttertoast.showToast(
            msg: "แจ้งเหตุขัดข้องสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        },
        child: Icon(
          Icons.save,
          size: 40.0,
        ),
        backgroundColor: Colors.pink[900],
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.blue,
      ),
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(
                        'กดกลับเพื่อแก้ไข',
                        style: TextStyle(fontFamily: 'Kanit'),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                'ตรวจสอบรายการแจ้งเหตุขัดข้อง',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'เหตุขัดข้อง : ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  widget.nameFormm,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'สถานที่เกิดเหตุขัดข้อง : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   widget.buildingNamee +
                                  //       widget.floorss +
                                  //       widget.roomss +
                                  //       widget.moreFormm,
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: TextStyle(color: Colors.red),
                                  // ),
                                  if (widget.moreFormm == '' ||
                                      widget.moreFormm == null)
                                    Row(
                                      children: [
                                        Text('อาคาร ${widget.buildingNamee} ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Text('ชั้น ${widget.floorss} ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Text('ลำดับห้อง ${widget.roomss} ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    )
                                  else
                                    Row(
                                      children: [
                                        Text('${widget.moreFormm} ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  // Text('อาคาร ${widget.buildingNamee} ',
                                  //     style: TextStyle(color: Colors.red)),
                                  // Text('ชั้น ${widget.floorss} ',
                                  //     style: TextStyle(color: Colors.red)),
                                  // Text('ลำดับห้อง ${widget.roomss} ',
                                  //     style: TextStyle(color: Colors.red)),
                                  // Text('${widget.moreFormm} ',
                                  //     maxLines: 2,
                                  //     overflow: TextOverflow.ellipsis,
                                  //     style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'เลขครุภัณฑ์ (เครื่องปรับอากาศ) : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            showContent(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'เบอร์โทร : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  widget.phonee,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              child: SizedBox(
                                height: 56,
                                child: TabBar(
                                  // controller: controller,
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
                                      color: Colors.blue[300]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                children: [
                                  if (widget.file1 == null)
                                    Text(
                                      'ไม่มีรูปภาพ',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  else if (widget.file1 != null)
                                    ClipRect(
                                      child: InteractiveViewer(
                                        maxScale: 20,
                                        child: Image.file(widget.file1),
                                      ),
                                    ),
                                  if (widget.file2 == null)
                                    Container(
                                      child: Center(
                                          child: Text(
                                        'ไม่มีรูปภาพ',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                    )
                                  else if (widget.file2 != null)
                                    ClipRect(
                                      child: InteractiveViewer(
                                        maxScale: 20,
                                        child: Image.file(widget.file2),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
