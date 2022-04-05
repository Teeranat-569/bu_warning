import 'dart:convert';

import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Datauser extends StatefulWidget {
  final UserModel warningModel;
  String idHolder, idBuilding;
  Datauser({Key key, this.warningModel, this.idHolder, this.idBuilding})
      : super(key: key);
  @override
  _DatauserState createState() => _DatauserState();
}

class _DatauserState extends State<Datauser> {
  bool loadStatus, status;
  // ignore: deprecated_member_use
  List<UserModel> filterUserModels = List();
  // ignore: deprecated_member_use
  List<UserModel> userModels = List();
  String idUser, userGender, userName, userPassword, userStudenID, position;
  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'ข้อมูลผู้ใช้',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kanit',
                            fontSize: 20),
                      ),
                    )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.orange[800],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'id ผู้ใช้',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          idUser == null
                              ? LinearProgressIndicator(
                                  color: Colors.orange[800],
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  '$idUser',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 132,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ชื่อ - นามสกุล',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          userName == null
                              ? LinearProgressIndicator(
                                  color: Colors.orange[800],
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  '$userName',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'รหัสนักศึกษาหรือชื่อผู้ใช้',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          userStudenID == null
                              ? LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: Colors.orange[800],
                                )
                              : Text(
                                  '$userStudenID',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 232,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เพศ',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (userGender == 'Female')
                            Text(
                              'หญิง',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          else if (userGender == 'male')
                            Text(
                              'ชาย',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'รหัสผ่าน',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          userPassword == null
                              ? LinearProgressIndicator(
                                  color: Colors.orange[800],
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  '$userPassword',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 182,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.indigo.shade50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ตำแหน่ง',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (position == 'student')
                            Text(
                              'นักศึกษา',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          else if (position == 'officer')
                            Text(
                              'เจ้าหน้าที่',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          else if (position == 'teacher')
                            Text(
                              'คณาจารย์',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          else
                            Text(
                              '$position',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> getAllUser() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String idUser = preferences.getString('id');

    // idUser = preferences.getString('idUser');
    // userGender = preferences.getString('UserGender');
    // userName = preferences.getString('UserName');
    // userPassword = preferences.getString('UserPassword');
    // userStudenID = preferences.getString('UserStudentID');
    // position = preferences.getString('UserPosition');
    String url =
        '${Myconstant().domain}/appkk/getUserWhereUserName.php?isAdd=true&name=${widget.idHolder}';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');
        print('**********************$idUser');
        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
            filterUserModels = userModels;
            idUser = userModel.id;
            userName = userModel.name;
            userStudenID = userModel.studentId;
            userGender = userModel.gender;
            userPassword = userModel.password;
            position = userModel.position;
          });
        }
      } else {
        status = false;
      }
    });
  }
}
