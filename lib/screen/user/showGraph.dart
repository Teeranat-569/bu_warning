// import 'dart:convert';

// import 'package:app_bu/models/building_model.dart';
// import 'package:app_bu/models/rate_model.dart';
// import 'package:app_bu/utility/my_constant.dart';
// import 'package:app_bu/utility/my_style.dart';
// import 'package:app_bu/utility/upper_curve_clipper.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:loading/indicator/ball_pulse_indicator.dart';
// import 'package:loading/loading.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// // ignore: must_be_immutable
// class ShowGraph extends StatefulWidget {
//   final BuildingModel buildingModel;
//   String idHolder, idBuilding;
//   ShowGraph({Key key, this.buildingModel, this.idHolder, this.idBuilding})
//       : super(key: key);

//   @override
//   _ShowGraphState createState() => _ShowGraphState();
// }

// class _ShowGraphState extends State<ShowGraph> {
//   String idName, buildName;
//   bool loadStatus;
//   double avg, re = 0, sum, sum2;
//   int sumAvg;
//   // ignore: deprecated_member_use
//   List<RateModel> rateModels = List();
//   // ignore: deprecated_member_use
//   List<BuildingModel> bModels = List();
//   String reStr, idLogin, nameUser;
//   String sumed;
//   bool status;
//   // ignore: deprecated_member_use
//   List<RateModel> filterRateModels = List();
//   // ignore: deprecated_member_use
//   List<BuildingModel> filterBModels = List();
//   double valued;
//   // double value;

//   @override
//   void initState() {
//     super.initState();
//     // showRate();
//     // aboutNotofication();
//     // getAllBuilding();
//     // showAllBuilding();
//     showBuildname();
//   }

//   Future showBuildname() async {
//     // SharedPreferences preferences = await SharedPreferences.getInstance();
//     // String idUser = preferences.getString('id');
//     // buildName = preferences.getString('idBuildName');
//     // idName = preferences.getString('BuildName');
//     // print('777777777777777777777777777777777777$buildName');

//     String url =
//         '${Myconstant().domain}/appkk/getAllDataWhereNameBuilding.php?isAdd=true&buildForm=${widget.idHolder}';
//     print('555555555555555555555555555555555555555555${widget.idBuilding}');
//     print(
//         '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${widget.idHolder}');
//     await Dio().get(url).then((value) {
//       setState(() {
//         loadStatus = false;
//       });
//       if (value.toString() != 'null') {
//         print('value >>>>>>>>$value');

//         var result = json.decode(value.data);
//         print('ree >>>>>>>>>>> $result');

//         for (var map in result) {
//           RateModel rateModel2 = RateModel.fromJson(map);
//           // BuildingModel rateModel3 = BuildingModel.fromJson(map);
//           setState(() {
//             rateModels.add(rateModel2);
//             filterRateModels = rateModels;
//             // buildName = rateModel2.buildForm;
//             // bModels.add(rateModel3);
//             // filterBModels = bModels;
//             // idName = rateModel3.buildingName;
//             // print('++++++++++++++++++++++++++++++++++++++$buildName');
//             // print('66666666666666666666666666666666666666666666666$idName');
//             avg = double.parse('${rateModel2.rate}');
//             sumAvg = rateModels.length;
//             print('=======================================$avg');
//             print(
//                 '=======================================////////////////$sumAvg');
//             for (var i = sumAvg; i <= sumAvg; i++) {
//               re = re + avg;
//               // if (i == 1) {
//               //   break ;
//               // }
//             }
//             print(
//                 '///////////////////////////////////////////////////////////////////////$re');
//             sum = re / sumAvg;
//             sumed = sum.toStringAsFixed(2);
//             double sumDou = double.parse('$sumed');
//             print(
//                 '+++++++++++++++++++++++++++++++++++++++++++++++++++++$sumed');
//             if (sumDou <= 1.80) {
//               reStr = 'น้อยที่สุด';
//             } else if (sumDou <= 2.60) {
//               reStr = 'น้อย';
//             } else if (sumDou <= 3.40) {
//               reStr = 'ปานกลาง';
//             } else if (sumDou <= 4.20) {
//               reStr = 'มาก';
//             } else {
//               reStr = 'มากที่สุด';
//             }
//           });
//         }
//       } else {
//         status = false;
//       }
//     });
//   }

//   Widget showListdata() {
//     return ListView.separated(
//       padding: EdgeInsets.all(10),
//       shrinkWrap: true,
//       physics: ScrollPhysics(),
//       itemCount: rateModels.length,
//       itemBuilder: (context, index) {
//         sum2 = double.parse('${filterRateModels[index].rate}');
//         return Column(
//           children: [
//             // Text('${filterRateModels[index].buildForm}'),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SmoothStarRating(
//                           color: Colors.pink,
//                           rating:
//                               double.parse('${filterRateModels[index].rate}'),
//                           isReadOnly: false,
//                           size: 20,
//                           filledIconData: Icons.star,
//                           halfFilledIconData: Icons.star_half,
//                           defaultIconData: Icons.star_border,
//                           starCount: 5,
//                           allowHalfRating: true,
//                           spacing: 2.0,
//                           onRated: (value) {
//                             setState(() {
//                               valued = value;
//                               print("rating value -> $value");
//                             });
//                           },
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           '(${filterRateModels[index].rate})',
//                           style: TextStyle(color: Colors.grey),
//                         )
//                       ],
//                     ),
//                     // Column(
//                     //   children: [
//                     //     Text(
//                     //       filterRateModels[index].buildForm,
//                     //       style: TextStyle(fontSize: 12.0),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     if (filterRateModels[index].commentRec == null ||
//                         filterRateModels[index].commentRec == 'null')
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 12.0),
//                       )
//                     else
//                       Text(
//                         '${filterRateModels[index].commentRec}',
//                         style: TextStyle(fontSize: 12.0),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         );

//         // RaisedButton(
//         //     onPressed: () {
//         //       route12(
//         //           ShowGraph(), rateModels[index], buildingModels[index]);
//         //     },
//         //     padding: const EdgeInsets.all(5),
//         //     child: Padding(
//         //       padding: const EdgeInsets.all(5.0),
//         //       child: Row(
//         //         children: [
//         //           Text(
//         //             '${filterBuildingModels[index].buildingName}',
//         //             // style: TextStyle(fontSize: 18),
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //     color: Colors.white,
//         //     shape: new RoundedRectangleBorder(
//         //         borderRadius: new BorderRadius.circular(10.0)));
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return Divider(
//           color: Colors.black,
//           height: 20,
//         );
//       },
//     );
//   }

//   Widget showContentUserWarning() {
//     return status == false
//         ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                   child: Text(
//                 'ไม่มีคะแนนความพึงพอใจ',
//                 style: TextStyle(color: Colors.grey),
//               )),
//             ],
//           )
//         : showListdata();
//   }

//   Widget sume() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                     child: widget.idHolder == null
//                         ? LinearProgressIndicator()
//                         : Text(
//                             '${widget.idHolder}',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Kanit',
//                                 fontSize: 18),
//                           ))),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50.0),
//               color: Colors.teal[800],
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Center(
//                     child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (sumed == null)
//                       Text(
//                         '0.0',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 40,
//                         ),
//                       )
//                     else if (sumed != null)
//                       Text(
//                         '$sumed',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 40,
//                         ),
//                       ),
//                   ],
//                 )),
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.0),
//                   color: Colors.indigo.shade50,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Text("มีความพึงพอใจในระดับ",
//                         style: TextStyle(
//                           fontSize: 18,
//                         ))),
//                 if (reStr == null)
//                   // Padding(
//                   //   child: Text(
//                   //     'xxxxxx',
//                   //     style: TextStyle(
//                   //         fontSize: 30.0,
//                   //         fontWeight: FontWeight.bold,
//                   //         fontStyle: FontStyle.italic,
//                   //         color: Colors.purple),
//                   //   ),
//                   //   padding: EdgeInsets.all(5.0),
//                   // )
//                   Loading(
//                       indicator: BallPulseIndicator(),
//                       size: 50.0,
//                       color: Colors.purple)
//                 else if (reStr != null)
//                   Padding(
//                     child: Text(
//                       '$reStr',
//                       style: TextStyle(
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           color: Colors.purple),
//                     ),
//                     padding: EdgeInsets.all(5.0),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Stack(
//             children: [
//               ClipPath(
//                 clipper: UpperClipper(),
//                 child: Container(
//                   height: 200,
//                   // width: 200,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.teal[100], Colors.teal[100]],
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   sume(),

//                   // loadStatus ==null
//                   // ? MyStyle().showProgress()
//                   // : RefreshIndicator(
//                   //     onRefresh: showBuildname,
//                   //     child: showContentUserWarning()),
//                   Expanded(
//                     child: RefreshIndicator(
//                       onRefresh: showBuildname,
//                       child: SingleChildScrollView(
//                         child: Stack(
//                           children: [
//                             loadStatus == null
//                                 ? MyStyle().showProgress()
//                                 : showContentUserWarning(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
