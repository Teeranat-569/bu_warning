import 'dart:convert';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/models/warning_model.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// ignore: must_be_immutable
class SumWarningMore extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String moreForm;
  // ignore: non_constant_identifier_names
  SumWarningMore({Key key, this.moreForm});
  @override
  _SumWarningMoreState createState() => _SumWarningMoreState();
}

class _SumWarningMoreState extends State<SumWarningMore> {
  bool loadStatus = true;
  bool status = true; // have data
  // ignore: deprecated_member_use
  List<WarningModel> warningModels = List();
  List<RateModel> rateModels = List();
  String rate, place;
  double avg, re = 0, sum, sum2;
  int sumAvg;
  String reStr, idLogin, nameUser;
  String sumed;
  double valued;

  @override
  void initState() {
    super.initState();
    // showDataFIX();
    showBuildname();
    // showData();
  }

  Future<Null> showData() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // idWarning = preferences.getString('idWarning');

    String url =
        '${Myconstant().domain}/appkk/kkk.php?isAdd=true&build_kk=${widget.moreForm}';
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

        setState(() {
          warningModels.add(warningModel);

          // nameForm = warningModel.nameForm;
          // dateTimeWarning = warningModel.dateTimeWarning;
          // time = warningModel.time;
          // buildForm = warningModel.buildForm;
          // airForm = warningModel.airForm;
          // path = warningModel.fileIMG;
          // path2 = warningModel.fileIMG2;
          // nameUser = warningModel.nameUser;
          // agency = warningModel.agency;
          // phone = warningModel.phone;
          // status = warningModel.status;
          rate = warningModel.rate;
        });
      }
    } catch (e) {}
  }

  Future showBuildname() async {
    String url =
        '${Myconstant().domain}/appkk/getAllDataWhereMoreForm.php?isAdd=true';
    print('555555555555555555555555555555555555555555${widget.moreForm}');
    print(
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${widget.moreForm}');
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          WarningModel rateModel = WarningModel.fromJson(map);
          // BuildingModel rateModel3 = BuildingModel.fromJson(map);
          setState(() {
            warningModels.add(rateModel);
            // place = rateModel.moreForm;
            // filterRateModels = rateModels;
            // buildName = rateModel2.buildForm;
            // bModels.add(rateModel3);
            // filterBModels = bModels;
            // idName = rateModel3.buildingName;
            // print('++++++++++++++++++++++++++++++++++++++$buildName');
            // print('66666666666666666666666666666666666666666666666$idName');
            avg = double.parse('${rateModel.rate}');
            sumAvg = warningModels.length;
            print('=======================================$avg');
            print(
                '=======================================////////////////$sumAvg');
            for (var i = sumAvg; i <= sumAvg; i++) {
              re = re + avg;
              // if (i == 1) {
              //   break ;
              // }
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

  Widget showListdata() {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: warningModels.length,
      itemBuilder: (context, index) {
        sum2 = double.parse('${warningModels[index].rate}');
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (warningModels[index].moreForm == null ||
                        warningModels[index].moreForm == 'null'
                    // warningModels[index].rate == null ||
                    // warningModels[index].rate == '' ||
                    // warningModels[index].rate == '0' ||
                    // warningModels[index].commentRec == null
                    )
                      Row(
                        children: [],
                      )
                    else
                      Text('${warningModels[index].moreForm}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmoothStarRating(
                          color: Colors.pink,
                          rating: double.parse('${warningModels[index].rate}'),
                          isReadOnly: false,
                          size: 20,
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
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(${warningModels[index].rate})',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       filterRateModels[index].buildForm,
                    //       style: TextStyle(fontSize: 12.0),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                Row(
                  children: [
                    if (warningModels[index].commentRec == null ||
                        warningModels[index].commentRec == 'null')
                      Text(
                        '',
                        style: TextStyle(fontSize: 12.0),
                      )
                    else
                      Text(
                        '${warningModels[index].commentRec}',
                        style: TextStyle(fontSize: 12.0),
                      ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.black,
          height: 20,
        );
      },
    );
  }

  Widget showContent() {
    return status == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'ไม่มีคะแนนความพึงพอใจ',
                style: TextStyle(color: Colors.grey),
              )),
            ],
          )
        : showListdata();
  }

  Widget sume() {
    return Column(
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
                          fontSize: 25,
                        ),
                      )
                    else if (sumed != null)
                      Text(
                        '$sumed',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                  ],
                )),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("มีความพึงพอใจในระดับ",
                        style: TextStyle(
                          fontSize: 14,
                        ))),
                if (reStr == null)
                  Padding(
                    child: Text(
                      'น้อยที่สุด',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.purple),
                    ),
                    padding: EdgeInsets.all(5.0),
                  )
                // Loading(
                //     indicator: BallPulseIndicator(),
                //     size: 25.0,
                //     color: Colors.purple)
                else if (reStr != null)
                  Padding(
                    child: Text(
                      '$reStr',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.purple),
                    ),
                    padding: EdgeInsets.all(5.0),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.amber[600],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'สถานที่อื่นๆ',
                          style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
                        ),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.yellow[600],
                      ),
                    ),
                  ),
                  // Text("888888888888888$rate"),
                  // showListdata(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ดำเนินการเข้าซ่อมบำรุง  ',
                        style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[300],
                        ),
                        child: Text(
                          '  ${warningModels.length}  ',
                          style: TextStyle(fontFamily: 'Kanit', fontSize: 20),
                        ),
                      ),
                      Text(
                        '  ครั้ง',
                        style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: sume(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.amber[200],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: showBuildname,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            loadStatus == null
                                ? MyStyle().showProgress(Colors.amber)
                                : showContent(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
