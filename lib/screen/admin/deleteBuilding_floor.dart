import 'dart:convert';

import 'package:app_bu/models/cateBuilding_model.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:app_bu/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DelFloor extends StatefulWidget {
  @override
  _DelFloorState createState() => _DelFloorState();
}

class _DelFloorState extends State<DelFloor> {
  bool loadStatus = true;
  bool status = true;
  // ignore: deprecated_member_use
  List<CateBuildingModel> catebuildingModels = List();
  String buildingStr;

  @override
  void initState() {

    super.initState();
    getAllhouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text('ลบชั้น'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => DelFloor());
                Navigator.of(context).pushReplacement(materialPageRoute);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: getAllhouse,
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
              ),Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        MaterialPageRoute materialPageRoute = MaterialPageRoute(
                            builder: (BuildContext context) => DelFloor());
                        Navigator.of(context)
                            .pushReplacement(materialPageRoute);
                      },
                      icon: Icon(Icons.refresh)),
                  Text('refresh'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> getAllhouse() async {
    String url = '${Myconstant().domain}/appkk/getAllhouse2.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        print('value >>>>>>>>$value');

        var result = json.decode(value.data);
        print('ree >>>>>>>>>>> $result');

        for (var map in result) {
          setState(() {
            CateBuildingModel cateBuildingModel =
                CateBuildingModel.fromJson(map);

            catebuildingModels.add(cateBuildingModel);
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
      itemCount: catebuildingModels.length,
      itemBuilder: (context, index) {
        if (catebuildingModels[index].buildKk == '0') {
          return Row(
            children: [],
          );
        } else
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.indigo.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ชั้นที่ ${catebuildingModels[index].floorspp}'),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    myAlert2(index);
                    print(
                        '***********---------------------${catebuildingModels[index].buildId}');
                  },
                  color: Colors.red,
                )
              ],
            ),
          );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.white,
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
                'ไม่มีข้อมูล',
                style: TextStyle(color: Colors.grey),
              )),
            ],
          )
        : showListdata();
  }

  Widget addButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.pink.shade900,
        child: Text('เพิ่มเลขชั้น',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
        onPressed: () {
          if (buildingStr == null || buildingStr.isEmpty) {
            myAlert('มีช่องว่าง', 'กรุณากรอกข้อมูลให้ครบ');
          } else {
            addBuildingThread();
            print('Success');
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => DelFloor());
            Navigator.of(context).pushReplacement(materialPageRoute);
            Fluttertoast.showToast(
              msg: "เพิ่มสำเร็จ",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        });
  }

  Widget buildingNameForm() {
    return TextFormField(
      onChanged: (value) => buildingStr = value.trim(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.add,
          color: Colors.pink.shade900,
          size: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
          gapPadding: 2.0,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'กรอกเลขชั้น',
        labelStyle: TextStyle(
            color: Colors.pink.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.warning,
                color: Colors.red,
                size: 40.0,
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future<Null> addBuildingThread() async {
    String url =
        '${Myconstant().domain}/appkk/addDatahouse_floors.php?isAdd=true&build_kk=0&floorspp=$buildingStr&numRoom=0';
    try {
      Response response = await Dio().get(url);
      print('----------$response');
      var result = json.decode(response.data);
      print('----------$result');
    } catch (e) {}
  }

  void myAlert2(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  'ลบสถานที่',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
              content: Text(
                'คุณต้องการลบชั้นที่ ${catebuildingModels[index].floorspp} ออกหรือไม่?',
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cancleButton(),
                    okButton(index),
                  ],
                ),
              ]);
        });
  }

  Widget cancleButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'ยกเลิก',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget okButton(int index) {
    // ignore: deprecated_member_use
    return FlatButton(
        onPressed: () {
          deleteData(catebuildingModels[index].buildId);
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => DelFloor());
          Navigator.of(context).pushReplacement(materialPageRoute);

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => DelFloor()));
          Fluttertoast.showToast(
            msg: "ลบสถานที่สำเร็จ",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            fontSize: 16,
          );
        },
        child: Text(
          'ตกลง',
          style: TextStyle(color: Colors.green),
        ));
  }

  Future<Null> deleteData(id) async {
    FirebaseMessaging firebase = FirebaseMessaging();
    String token = await firebase.getToken();
    print('token =========$token');
    String url =
        '${Myconstant().domain}/appkk/editDataWhereidFloor.php?isAdd=true&floorspp='
        '&build_id=$id';
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii $id');
    try {
      Response response = await Dio().get(url);
      print('----------$response');
    } catch (e) {}
  }
}
