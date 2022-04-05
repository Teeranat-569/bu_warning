import 'dart:convert';

import 'package:app_bu/models/maintenance_models.dart';
import 'package:app_bu/screen/admin/showData_admin.dart';
import 'package:app_bu/screen/admin/statusBar_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeMTN extends StatefulWidget {
  // const ChangeMTN({ Key? key }) : super(key: key);

  @override
  _ChangeMTNState createState() => _ChangeMTNState();
}

class _ChangeMTNState extends State<ChangeMTN> {
  String selected, idWarning;
  List data = List();

  @override
  void initState() {
    super.initState();

    getAllMTN();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            borderRadius: new BorderRadius.circular(20.0)),
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
          ],
        ),
      ),
    );
  }

  Future<Null> sendToMTN() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idWarning = preferences.getString('idWarning');

    String url =
        '${Myconstant().domain}/appkk/editDataWhereidWarning.php?isAdd=true&id=$idWarning&mtn_autoID=$selected';
    print('7777777777777777777777777777777777777777$idWarning');
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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange[200],
        textColor: Colors.black,
        fontSize: 16,
      );
    } catch (e) {}
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
        String title = 'ซ่อมแซมสำเร็จแล้ว';
        String body = 'ให้คะแนนความพึงพอใจได้เลย...';

        String urlSendToken =
            '${Myconstant().domain}/appkk/apiNotificationtoMTN.php?isAdd=true&token_mtn=$tokenAdmin&title=$title&body=$body';
        sendNotificationTOMTN(urlSendToken);
        print('------------------------------------$tokenAdmin');
      }
    });
  }

  Future<Null> sendNotificationTOMTN(String urlSendToken) async {
    await Dio().get(urlSendToken).then((value) => Fluttertoast.showToast(
          msg: "แจ้งสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        ));
  }
}
