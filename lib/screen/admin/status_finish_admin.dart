import 'dart:convert';

import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/admin/showData_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  bool loadStatus = true;
  bool status = true;
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();

  @override
  void initState() {
    super.initState();
    showDataUSERWARNING();
  }

  Future<Null> showDataUSERWARNING() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=FInish';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');
        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');
        for (var map in result) {
          WarningModel warningModel = WarningModel.fromJson(map);
          setState(() {
            warningModels.add(warningModel);
          });
        }
      } else {
        status = false;
      }
    });
  }

  Widget showContentUserWarning() {
    return status == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'ไม่มีรายกา่รแจ้งเหตุขัดข้อง',
                style: TextStyle(color: Colors.grey),
              )),
            ],
          )
        : showListdata();
  }

  Widget showListdata() {
    return RefreshIndicator(
      onRefresh: showDataUSERWARNING,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 12),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: warningModels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade200,
              ),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  route(ShowIdWarning(), warningModels[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${warningModels[index].nameForm}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              warningModels[index].dateTimeWarning,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            if (warningModels[index].status == 'UserWarning')
                              Text(
                                'ผู้ใช้แจ้งเหตุ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else if (warningModels[index].status == 'Fix')
                              Text(
                                'กำลังดำเนินการ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else if (warningModels[index].status == 'FInish')
                              Text(
                                'เสร็จสิ้น',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                            if (warningModels[index].mtnAutoID == null ||
                                warningModels[index].mtnAutoID == '')
                              Row(
                                children: [
                                  Text(
                                    'ผู้ดำเนินการ ',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'ไม่ได้กำหนด',
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Text(
                                    'ผู้ดำเนินการ ',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    warningModels[index].mtnAutoID,
                                    style: TextStyle(
                                      color: Colors.pink, fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.orange[800],
                          ),
                          child: Center(
                              child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ))),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            color: Colors.white,
          );
        },
      ),
    );
  }

  Future<Null> route(Widget routeName, WarningModel warningModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', warningModel.id);
    preferences.setString('BuildWarning', warningModel.buildForm);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            loadStatus ? MyStyle().showProgress(Colors.amber) : showContentUserWarning(),
          ],
        ),
      ),
    );
  }
}
