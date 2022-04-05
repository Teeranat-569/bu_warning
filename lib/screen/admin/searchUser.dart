import 'dart:convert';

import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dataUser.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  bool loadStatus, status;
  // ignore: deprecated_member_use
  List<UserModel> filterUserModels = List();
  // ignore: deprecated_member_use
  List<UserModel> userModels = List();

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
        backgroundColor: Colors.amber,
      ),
      body: Stack(children: [
        Container(
          child: Column(
            children: [
              searchText(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: getAllUser,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        loadStatus == true
                            ? MyStyle().showProgress(Colors.amber)
                            : showContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget showContent() {
    return status == false
        ? Center(child: Text('ไม่มีการแสดงความคิดเห็น'))
        : showListdata();
  }

  Future<Null> route12(Widget routeName, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idUser', userModel.id);
    preferences.setString('UserGender', userModel.gender);
    preferences.setString('UserName', userModel.name);
    preferences.setString('UserPassword', userModel.password);
    preferences.setString('UserStudentID', userModel.studentId);
    preferences.setString('UserPosition', userModel.position);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Future<Null> getAllUser() async {
    String url = '${Myconstant().domain}/appkk/getAllUser.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
            filterUserModels = userModels;
          });
        }
      } else {
        status = false;
      }
    });
  }

  Widget showListdata() {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: filterUserModels.length,
      itemBuilder: (context, index) {
        // ignore: deprecated_member_use
        return RaisedButton(
            onPressed: () {
              route12(Datauser(), userModels[index]);
            },
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${filterUserModels[index].id}',
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${filterUserModels[index].name}',
                ),
              ],
            ),
            color: Colors.amber[100],
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.white,
        );
      },
    );
  }

  Widget searchText() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.amber[50],
              prefixIcon: Icon(
                Icons.search,
                color: Colors.amber,
              ),
              labelText: 'ค้นหาชื่อ - นามสกุลผู้ใช้',
              labelStyle: TextStyle(color: Colors.amber)),
          onChanged: (value) {
            setState(() {
              filterUserModels = userModels
                  .where((u) =>
                      (u.name.toLowerCase().contains(
                        value.toLowerCase())))
                  .toList();
            });
          }),
    );
  }
}
