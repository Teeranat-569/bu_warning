import 'dart:convert';

import 'package:app_bu/models/rate_model.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:app_bu/utility/upper_curve_clipper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// ignore: must_be_immutable
class ShowGraphAdmin extends StatefulWidget {
  String idHolder, idBuilding;
  ShowGraphAdmin({Key key, this.idHolder, this.idBuilding})
      : super(key: key);

  @override
  _ShowGraphAdminState createState() => _ShowGraphAdminState();
}

class _ShowGraphAdminState extends State<ShowGraphAdmin> {
  String idName, buildName;
  bool loadStatus;
  double avg, re = 0, sum, sum2;
  int sumAvg;
  // ignore: deprecated_member_use
  List<RateModel> rateModels = List();
  String reStr, idLogin, nameUser;
  String sumed;
  bool status;
  // ignore: deprecated_member_use
  List<RateModel> filterRateModels = List();
  double valued;

  @override
  void initState() {
    super.initState();
    showBuildname();
  }

  Future showBuildname() async {
    String url =
        '${Myconstant().domain}/appkk/getAllDataWhereNameBuilding.php?isAdd=true&buildForm=${widget.idHolder}';
    print('555555555555555555555555555555555555555555${widget.idBuilding}');
    print(
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${widget.idHolder}');
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          RateModel rateModel2 = RateModel.fromJson(map);
          setState(() {
            rateModels.add(rateModel2);
            filterRateModels = rateModels;
            avg = double.parse('${rateModel2.rate}');
            sumAvg = rateModels.length;
            print('=======================================$avg');
            print(
                '=======================================////////////////$sumAvg');
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

  Widget showListdata() {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: rateModels.length,
      itemBuilder: (context, index) {
        sum2 = double.parse('${filterRateModels[index].rate}');
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmoothStarRating(
                          color: Colors.pink,
                          rating:
                              double.parse('${filterRateModels[index].rate}'),
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
                          '(${filterRateModels[index].rate})',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (filterRateModels[index].commentRec == null ||
                        filterRateModels[index].commentRec == 'null')
                      Text(
                        '',
                        style: TextStyle(fontSize: 12.0),
                      )
                    else
                      Text(
                        '${filterRateModels[index].commentRec}',
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

  Widget showContentUserWarning() {
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: widget.idHolder == null
                        ? LinearProgressIndicator()
                        : Text(
                            '${widget.idHolder}',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kanit',
                                fontSize: 18),
                          ))),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.amber[800],
            ),
          ),
        ),
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
                          fontSize: 18,
                        ))),
                if (reStr == null)
                  Loading(
                      indicator: BallPulseIndicator(),
                      size: 50.0,
                      color: Colors.purple)
                else if (reStr != null)
                  Padding(
                    child: Text(
                      '$reStr',
                      style: TextStyle(
                          fontSize: 30.0,
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              ClipPath(
                clipper: UpperClipper(),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber[100], Colors.amber[100]],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  sume(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: showBuildname,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            loadStatus == null
                                ? MyStyle().showProgress(Colors.amber)
                                : showContentUserWarning(),
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
      ),
    );
  }
}
