import 'dart:io';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/screen/admin/sumWarningBuilding.dart';
import 'package:app_bu/screen/admin/sumWarningMoreForm.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:overlay_support/overlay_support.dart';

class AutoCompleteDemoBuildingAdmin extends StatefulWidget {
  AutoCompleteDemoBuildingAdmin() : super();

  final String title = "สถิติความพึงพอใจ";

  @override
  _AutoCompleteDemoBuildingAdminState createState() =>
      _AutoCompleteDemoBuildingAdminState();
}

class _AutoCompleteDemoBuildingAdminState
    extends State<AutoCompleteDemoBuildingAdmin> {
  AutoCompleteTextField searchTextField;
  bool loading = true;
  TextEditingController controller = TextEditingController();
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels = List();
  // ignore: unused_field
  ListItem _selectedItem;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem rateModel;
  String idBuilding;
  double avg, re = 0, sum, sum2;
  int sumAvg;
  String reStr, idLogin, nameUser, sumed, name;
  // ignore: unused_field
  String _chosenValue, _value, _chosenValue2, _value2;
  RateModel rateModelf;
  List data = List();
  String kk = 'สถานที่อื่นๆ';
  @override
  void initState() {
    // getAllBuilding();
    // getAllBuilding2();
    showRate2();
    getAllMTN();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
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

  bool loadStatus = true;
  bool status = true;

  Widget sumScore() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.amber,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (sumed == null)
                        Text(
                          '0.0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        )
                      else if (sumed != null)
                        Text(
                          '$sumed',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        ),
                    ],
                  )),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.indigo.shade50,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("มีความพึงพอใจในระดับ",
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                  if (reStr == null)
                    Padding(
                      child: Text(
                        'xxxxxx',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.pink),
                      ),
                      padding: EdgeInsets.all(5.0),
                    )
                  else if (reStr != null)
                    Padding(
                      child: Text(
                        '$reStr',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.pink[900]),
                      ),
                      padding: EdgeInsets.all(5.0),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Future<Null> route(
    Widget routeName,
  ) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> showRate2() async {
    String url = '${Myconstant().domain}/appkk/getAllRate.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          rateModelf = RateModel.fromJson(map);
          setState(() {
            rateModels.add(rateModelf);
            filterRateModels = rateModels;
            avg = double.parse('${rateModelf.rate}');
            sumAvg = rateModels.length;
            print('=======================================$avg');

            for (var i = sumAvg; i <= sumAvg; i++) {
              re = re + avg;
            }
            print(
                '///////////////////////////////////////////////////////////////////////$re');
            sum = re / sumAvg;
            sumed = sum.toStringAsFixed(2);
            double sumDou = double.parse('$sumed');
            print(
                '+++++++++++++++++++++++++++++++++++++++++++++++++++++$sumed');
            if (sumDou <= 1.80) {
              reStr = 'น้อยที่สุด';
            } else if (sumDou <= 2.60) {
              reStr = 'น้อย';
            } else if (sumDou <= 3.40) {
              reStr = 'ปานกลาง';
            } else if (sumDou <= 4.20) {
              reStr = 'มาก';
            } else {
              reStr = 'มากที่สุด';
            }
          });
        }
      } else {
        status = false;
      }
    });
  }

  Future getAllMTN() async {
    var response = await http.get(
        "${Myconstant().domain}/appkk/getAllhouse.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });

    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: 40,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Kanit'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ความพึงพอใจโดยรวมทั้งหมดจากผู้ใช้งาน',
                      style: TextStyle(fontFamily: 'Kanit', fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    sumScore(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ความพึงพอใจรายอาคาร',
                      style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            color: Colors.pink[100],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    value: _chosenValue,
                                    hint: Text('เลือกอาคาร'),
                                    items: data.map((list) {
                                      return DropdownMenuItem(
                                        child: Column(
                                          children: [
                                            Text('อาคาร ' + list['build_kk']),

                                            // Text(list['build_kk']),
                                          ],
                                        ),
                                        value: list['build_kk'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _chosenValue = value;
                                        print('555555555555555555' + value);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.pink[900],
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    onPressed: () {
                                      route(
                                        SumWarning(
                                          build_kk: _chosenValue,
                                        ),
                                      );
                                      // }
                                    },
                                    child: Text(
                                      'เลือกอาคาร',
                                      style: TextStyle(
                                          fontFamily: 'Kanit',
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: Colors.pink[100],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              color: Colors.pink[900],
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                route(
                                  SumWarningMore(
                                    moreForm: _chosenValue2,
                                  ),
                                );
                              },
                              child: Text(
                                'สถิติความพึงพอใจสถานที่อื่นๆ',
                                style: TextStyle(
                                    fontFamily: 'Kanit', color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> route23(
    Widget routeName,
  ) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
