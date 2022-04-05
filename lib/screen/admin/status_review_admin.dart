import 'dart:convert';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/screen/admin/showData_admin.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewStatus extends StatefulWidget {
  @override
  _ReviewStatusState createState() => _ReviewStatusState();
}

class _ReviewStatusState extends State<ReviewStatus> {
  bool loadStatus = true;
  bool status = true; // have data
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();
  RateModel rateModel;
  double valued;
  String rate;
  double r;
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels = List();
  //  bool loadStatus = true;
  bool loadStatusB = true;
  // bool status = true;
  bool statusB = true;
  String reStr, idLogin, nameUser;
  String reStrB;
  double avg, re = 0, sum;
  int sumAvg;
  String sumed;
  double avgB, reB = 0, sumB;
  int sumAvgB;
  String sumedB;
  // ignore: deprecated_member_use
  List<RateModel> rateModelsB = List();
  // ignore: deprecated_member_use
  var items = List<String>();
  // double valued;

  @override
  void initState() {
    super.initState();
    showDataUSERWARNING();
    // showRate();
  }

  Future<Null> showDataUSERWARNING() async {
    String url =
        '${Myconstant().domain}/appkk/getDataWhereStatus.php?isAdd=true&status=review';
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
          int indexD = index + 1;
          // ignore: deprecated_member_use
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
                  print('ppppppppppppppppppppppppppppp');
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              warningModels[index].dateTimeWarning,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            SizedBox(
                              height: 5,
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
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            else if (warningModels[index].status == 'review')
                              Row(
                                children: [
                                  SmoothStarRating(
                                    color: Colors.pink,
                                    rating: double.parse(
                                        '${warningModels[index].rate}'),
                                    isReadOnly: false,
                                    size: 10,
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
                                  Text(
                                    'ให้คะแนนเสร็จสิ้น',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.pink,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            if (warningModels[index].mtnAutoID == null ||
                                warningModels[index].mtnAutoID == '')
                              Row(
                                children: [
                                  Text(
                                    'ผู้ดำเนินการ ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontStyle: FontStyle.italic,
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
                                      // fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    warningModels[index].mtnAutoID,
                                    style: TextStyle(
                                      color: Colors.pink, fontSize: 12,
                                      // fontStyle: FontStyle.italic,
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
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.white,
            height: 0,
          );
        },
      ),
    );
  }

  Future<Null> route(Widget routeName, WarningModel warningModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idWarning', warningModel.id);

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
