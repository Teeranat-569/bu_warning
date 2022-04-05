import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/user/checkForm.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import 'autoSearch.dart';

// ignore: must_be_immutable
class Showlist1 extends StatefulWidget {
  final WarningModel warningModel;
  String idHolder, idBuilding, floors, rooms, buildingName, moreForm;
  Showlist1(
      {Key key,
      this.warningModel,
      this.idHolder,
      this.idBuilding,
      this.floors,
      this.rooms,
      this.buildingName,
      this.moreForm})
      : super(key: key);

  @override
  _Showlist1State createState() => _Showlist1State();
}

class _Showlist1State extends State<Showlist1> {
  final textFill = GlobalKey<FormState>();
  String nameForm,
      idUser,
      agency,
      phone,
      buildings,
      floor,
      numRoom,
      buildName,
      floorSTR,
      numRoomStr;
  String airProduct;
  var textEditController = TextEditingController();
  var airControl = TextEditingController();
  var agencyControl = TextEditingController();
  var phoneControl = TextEditingController();
  var formatdate;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  File file, file2;
  bool loadStatus = true;
  bool status = true;

  @override
  void initState() {
    super.initState();

    aboutNotofication();
  }

  Future<Null> aboutNotofication() async {
    print('About Noti Work...');
    if (Platform.isAndroid) {
      print('About Noti Work........Android');
      print(
          '********************************************************${widget.moreForm}');
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
      });
    } else if (Platform.isIOS) {
      print('About Noti Work........IOS');
    }
  }

  bool loading = true;

  Future<Null> route(
    Widget routeName,
  ) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> route2(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).pushReplacement(materialPageRoute);
  }

  Widget cancelButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.grey,
      child: Text(
        'ยกเลิก',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Kanit',
          fontSize: 16.0,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget resetButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.yellow.shade100,
      onPressed: () {
        textFill.currentState.reset();
        print('Reset');
      },
      child: Text(
        'รีเซ็ต',
        style: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('ยกเลิก'));
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
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameIMG);
      map['file2'] =
          await MultipartFile.fromFile(file2.path, filename: nameIMG2);
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
        // print(dateTimeWarning);
        print(
            '//////////////////////////////////////////////////////////////////' +
                formatdate);

        DateTime time = DateTime.now();
        String timeWarning = DateFormat('HH:mm').format(time);

        String urlInsert =
            '${Myconstant().domain}/appkk/addList.php?isAdd=true&DateTime_warning=$formatdate&time=$timeWarning&idUser=$idUser&nameUser=$nameUser&nameForm=$nameForm&idBuildForm=${widget.idBuilding}&buildForm=${widget.idHolder}&build_kk=${widget.buildingName}&floorpp=${widget.floors}&numRoom=${widget.rooms}&airForm=$airProduct&agency=$agency&phone=$phone&fileIMG=$urlPathPIC&fileIMG2=$urlPathPIC2&status=UserWarning&token=$token&end_date=NO Date&time_end=NO time';
        await Dio().get(urlInsert).then((value) {
          print('--------------------Success');
        });
      });
    } catch (e) {}
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            title: Text(
              title,
              style: TextStyle(fontFamily: 'Kanit'),
            ),
            content: Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.grey[200],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
  }

  Widget nameform() {
    return TextField(
      onChanged: (value) => nameForm = value.trim(),
      controller: textEditController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.create,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'ระบุเหตุขัดข้อง',
        labelStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          // fontFamily: 'Kanit',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildform() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if ((widget.buildingName == null ||
                widget.floors == null ||
                widget.rooms == null) &&
            widget.moreForm == null)
          Text('ระบุสถานที่ >>>> ',
              style: TextStyle(
                color: Colors.grey,
              ))
        // else if (widget.moreForm == null)
        //   Row(
        //     children: [
        //       Text('อาคาร ${widget.buildingName} ',
        //           style: TextStyle(color: Colors.black)),
        //       Text('ชั้น ${widget.floors} ',
        //           style: TextStyle(color: Colors.black)),
        //       Text('ลำดับห้อง ${widget.rooms} ',
        //           style: TextStyle(color: Colors.black)),
        //     ],
        //   )
        else
          Row(
            children: [
              if (widget.moreForm == null || widget.moreForm == '')
                Row(
                  children: [
                    Text('อาคาร ${widget.buildingName} ',
                        style: TextStyle(color: Colors.black)),
                    Text('ชั้น ${widget.floors} ',
                        style: TextStyle(color: Colors.black)),
                    Text('ลำดับห้อง ${widget.rooms} ',
                        style: TextStyle(color: Colors.black)),
                  ],
                )
              else
                Text('${widget.moreForm} ',
                    style: TextStyle(color: Colors.black))
            ],
          ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.teal,
          ),
          //
          width: 50,
          height: 50,
          child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                route(AutoCompleteDemo());
              }),
        )
      ],
    );
  }

  Widget airform() {
    return TextField(
      onChanged: (value) => airProduct = value.trim(),
      controller: airControl,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.ac_unit_rounded,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'เลขครุภัณฑ์ (เครื่องปรับอากาศ)',
        labelStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget agencyform() {
    return TextField(
      onChanged: (value) => agency = value.trim(),
      controller: agencyControl,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.apartment,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'หน่วยงานผู้ที่แจ้งเหตุขัดข้อง',
        labelStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget phoneform() {
    return TextField(
      onChanged: (value) => phone = value.trim(),
      controller: phoneControl,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.call,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'เบอร์โทรผู้ที่แจ้งเหตุขัดข้อง',
        labelStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          // fontFamily: 'Kanit',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget showImage() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        width: 355.0,
        height: 300.0,
        child: file == null
            ? Center(child: Text('ไม่ได้อัปโหลดรูปภาพ'))
            : ClipRect(
                child:
                    InteractiveViewer(maxScale: 20, child: Image.file(file))));
  }

  Widget showImage2() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        width: 355.0,
        height: 300.0,
        child: file2 == null
            ? Center(child: Text('ไม่ได้อัปโหลดรูปภาพ'))
            : ClipRect(
                child:
                    InteractiveViewer(maxScale: 20, child: Image.file(file2))));
  }

  Widget uploadImg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        gallaryButton(),
        SizedBox(
          height: 10.0,
        ),
        showImage(),
      ],
    );
  }

  Widget uploadImg2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        gallaryButton2(),
        SizedBox(
          height: 10.0,
        ),
        showImage2(),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      // ignore: deprecated_member_use
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<Null> chooseImage2(ImageSource imageSource2) async {
    try {
      // ignore: deprecated_member_use
      var object2 = await ImagePicker.pickImage(
        source: imageSource2,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file2 = object2;
      });
    } catch (e) {}
  }

  Widget gallaryButton() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.teal,
          ),
          width: 60,
          height: 60,
          child: IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 40.0,
              color: Colors.white,
            ),
            onPressed: () {
              chooseImage(ImageSource.gallery);
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        textupload(),
      ],
    );
  }

  Widget gallaryButton2() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.teal,
          ),
          //
          width: 60,
          height: 60,
          child: IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 40.0,
              color: Colors.white,
            ),
            onPressed: () {
              chooseImage2(ImageSource.gallery);
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        textupload(),
      ],
    );
  }

  Widget textupload() {
    return Text('อัปโหลดรูปภาพ');
  }

  Future<Null> notificationTOadmin(String idUser) async {
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

  Widget showContent() {
    return airProduct == null
        ? Text(
            'ไม่มี',
            style: TextStyle(color: Colors.grey),
          )
        : Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Text(airControl.text,
                    style: TextStyle(color: Colors.red))));
  }

  TextEditingController jj = TextEditingController();
  String building;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (nameForm == null || nameForm.isEmpty) {
                showAlert('คำเตือน!!!', 'กรุณากรอกข้อมูลให้ครบ');
              } else if (phone == null || phone.isEmpty) {
                showAlert(
                    'คำเตือน!!!', 'กรุณากรอกเบอร์โทรศัพท์เพื่อการติดต่อกลับ');
              } else if (file == null || file2 == null) {
                showAlert('คำเตือน!!!', 'กรุณาอัพโหลดรูปภาพ');
              } else {
                print(
                    'eeeeegggggeeeeeeeeeeeeeeeeeeeeeeeeee ${widget.buildingName}');
                print(
                    'eeeeeeggddddddddddeeeeeeeeeeeeeeeeeeeeeeeee ${widget.floors}');
                print(
                    'eeeeeeeeeee,,,,,,,,,,,eeeeeeeeeeeeeeeeeeee ${widget.rooms}');
                print(
                    'eeeeeeeeeeeeeeeejjjjjjjjjjjjjjjjjjjeeeeeeeeeeeeeee ${widget.moreForm}');
                route(CheckForm(
                  buildingg: widget.idHolder,
                  phonee: phoneControl.text,
                  airFormm: airControl.text,
                  nameFormm: textEditController.text,
                  file1: file,
                  file2: file2,
                  idBuildingg: widget.idBuilding,
                  buildingNamee: widget.buildingName,
                  floorss: widget.floors,
                  roomss: widget.rooms,
                  moreFormm: widget.moreForm,
                ));
              }
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 40.0,
            ),
            backgroundColor: Colors.orange[900],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'หน้าการแจ้งเหตุขัดข้อง',
          style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
        ),
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.yellow.shade50,
      body: DefaultTabController(
        length: 2,
        child: Container(
          color: Colors.teal[100],
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Form(
                key: textFill,
                child: ListView(children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'สถานที่เกิดเหตุขัดข้อง',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          buildform(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  nameform(),
                  SizedBox(
                    height: 10.0,
                  ),
                  airform(),
                  SizedBox(
                    height: 10.0,
                  ),
                  phoneform(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(children: <Widget>[
                    Text(
                      'บริเวณตำแหน่งที่เกิดเหตุขัดข้อง',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
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
                                  color: Colors.teal[300]),
                            ),
                          ),
                          SizedBox(
                            height: 500,
                            child: TabBarView(
                              children: [
                                uploadImg(),
                                uploadImg2(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    children: <Widget>[],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                  )
                ])),
          )),
        ),
      ),
    );
  }

  Future<Null> sendNotificationTOAdmin(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "ส่งไปยังฝ่ายซ่อมบำรุงสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange[800],
          textColor: Colors.white,
          fontSize: 16,
        ));
  }
}
