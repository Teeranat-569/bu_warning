import 'dart:io';
import 'package:app_bu/models/cateBuilding_model.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:overlay_support/overlay_support.dart';
import 'warningForm.dart';

class AutoCompleteDemo extends StatefulWidget {
  AutoCompleteDemo() : super();

  final String title = "เลือกสถานที่";

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  AutoCompleteTextField searchTextField2;
  AutoCompleteTextField searchTextField3;
  AutoCompleteTextField searchTextField4;
  GlobalKey<AutoCompleteTextFieldState<CateBuildingModel>> keyBuilding =
      new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<CateBuildingModel>> keyFloor =
      new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<CateBuildingModel>> keyRoom =
      new GlobalKey();
  // ignore: deprecated_member_use
  static List<CateBuildingModel> buildings = new List<CateBuildingModel>();
  // ignore: deprecated_member_use
  static List<CateBuildingModel> floors = new List<CateBuildingModel>();
  // ignore: deprecated_member_use
  static List<CateBuildingModel> roomss = new List<CateBuildingModel>();
  bool loading = true;
  bool loadings = true;
  bool loadingss = true;
  bool loadingsss = true;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerBuilding = TextEditingController();
  TextEditingController controllerFloor = TextEditingController();
  TextEditingController controllerRoom = TextEditingController();
  // ignore: deprecated_member_use
  List<CateBuildingModel> catebuildingModels = List();
  // ignore: deprecated_member_use
  List<CateBuildingModel> filterCateBuildingModels = List();
  // ignore: unused_field
  ListItem _selectedItem;
  // ignore: unused_field
  ListItem _selectedItem2;
  // ignore: unused_field
  ListItem _selectedItem3;
  // ignore: unused_field
  ListItem _selectedItem4;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems2;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems3;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems4;
  String idBuilding, moreForm, selected, selected2, selected3;
  var textEditController2 = TextEditingController();

  List data = List();
  List data2 = List();
  List data3 = List();

  @override
  void initState() {
    getUsers2();
    getUsers3();
    getUsers4();
    getAllMTN();
    getAllMTN2();
    getAllMTN3();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _dropdownMenuItems2 = buildDropDownMenuItems2(_dropdownItems2);
    _dropdownMenuItems3 = buildDropDownMenuItems3(_dropdownItems3);
    _dropdownMenuItems4 = buildDropDownMenuItems4(_dropdownItems4);
    _selectedItem2 = _dropdownMenuItems2[0].value;
    _selectedItem = _dropdownMenuItems[0].value;
    _selectedItem3 = _dropdownMenuItems3[0].value;
    _selectedItem4 = _dropdownMenuItems4[0].value;
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
        print('Noti OnLunch');
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

  // void getUsers() async {
  //   try {
  //     final response =
  //         await http.get("${Myconstant().domain}/appkk/getAllBuilding.php");
  //     if (response.statusCode == 200) {
  //       users = loadUsers(response.body);
  //       print('Users: ${users.length}');
  //       setState(() {
  //         loading = false;
  //       });
  //     } else {
  //       print("Error getting users.");
  //     }
  //   } catch (e) {
  //     print("Error getting users.");
  //   }
  // }

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

  Future getAllMTN2() async {
    var response = await http.get(
        "${Myconstant().domain}/appkk/getAllhouse2.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data2 = jsonData;
    });

    print(jsonData);
  }

  Future getAllMTN3() async {
    var response = await http.get(
        "${Myconstant().domain}/appkk/getAllhouse3.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data3 = jsonData;
    });

    print(jsonData);
  }

  void getUsers2() async {
    try {
      final response =
          await http.get("${Myconstant().domain}/appkk/getAllhouse.php");
      if (response.statusCode == 200) {
        buildings = loadUsers2(response.body);
        print('buildings: ${buildings.length}');
        setState(() {
          loadings = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  void getUsers3() async {
    try {
      final response =
          await http.get("${Myconstant().domain}/appkk/getAllhouse.php");
      if (response.statusCode == 200) {
        floors = loadUsers2(response.body);
        print('floors: ${floors.length}');
        setState(() {
          loadingss = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  void getUsers4() async {
    try {
      final response =
          await http.get("${Myconstant().domain}/appkk/getAllhouse.php");
      if (response.statusCode == 200) {
        roomss = loadUsers2(response.body);
        print('rooms: ${roomss.length}');
        setState(() {
          loadingsss = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  // static List<BuildingModel> loadUsers(String jsonString) {
  //   final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  //   return parsed
  //       .map<BuildingModel>((json) => BuildingModel.fromJson(json))
  //       .toList();
  // }

  static List<CateBuildingModel> loadUsers2(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<CateBuildingModel>((json) => CateBuildingModel.fromJson(json))
        .toList();
  }

  bool loadStatus = true;
  bool status = true;

  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<ListItem> _dropdownItems2 = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<ListItem> _dropdownItems3 = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<ListItem> _dropdownItems4 = [
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

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems2(List listItems2) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items2 = List();
    for (ListItem listItem2 in listItems2) {
      items2.add(
        DropdownMenuItem(
          child: Text(listItem2.name),
          value: listItem2,
        ),
      );
    }
    return items2;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems3(List listItems3) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items3 = List();
    for (ListItem listItem3 in listItems3) {
      items3.add(
        DropdownMenuItem(
          child: Text(listItem3.name),
          value: listItem3,
        ),
      );
    }
    return items3;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems4(List listItems4) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ListItem>> items4 = List();
    for (ListItem listItem4 in listItems4) {
      items4.add(
        DropdownMenuItem(
          child: Text(listItem4.name),
          value: listItem4,
        ),
      );
    }
    return items4;
  }

  Widget rowbuilding(CateBuildingModel building) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          building.buildKk,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget rowFloors(CateBuildingModel floors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          floors.floorspp,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget rowRoom(CateBuildingModel room) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          room.numRoom,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Future<Null> route(Widget routeName) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('idBuildName', user.id);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).pushReplacement(materialPageRoute);
  }

  Future<Null> route2(Widget routeName) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('idBuildName', rateModel.id);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  Widget moreForm2() {
    return TextField(
      onChanged: (value) => moreForm = value.trim(),
      controller: textEditController2,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.create,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: 'ระบุสถานที่อื่นๆ',
        labelStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
          // fontFamily: 'Kanit',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.teal[100],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'อาคาร : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: 150,
                        child: loadings
                            ? LinearProgressIndicator(
                                color: Colors.teal[100],
                                minHeight: 10,
                              )
                            : DropdownButton(
                                value: selected,
                                hint: Text('เลือกอาคาร'),
                                items: data.map((list) {
                                  return DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        Text('อาคาร ' + list['build_kk']),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        // Text(list['build_kk']),
                                      ],
                                    ),
                                    value: list['build_kk'].toString(),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selected = value;
                                    print('555555555555555555' + value);
                                  });
                                },
                              ),

                        // searchTextField2 =
                        //     AutoCompleteTextField<CateBuildingModel>(
                        //     controller: controllerBuilding,
                        //     key: keyBuilding,
                        //     clearOnSubmit: false,
                        //     suggestions: buildings,
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16.0,
                        //     ),
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        //       hintText:
                        //           "พิมพ์ค้นหาเลขอาคารที่เกิดเหตุขัดข้อง",
                        //       hintStyle: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     itemFilter: (item, query) {
                        //       return item.buildKk
                        //           .toLowerCase()
                        //           .contains(query.toLowerCase());
                        //     },
                        //     itemSorter: (a, b) {
                        //       return a.buildKk.compareTo(b.buildKk);
                        //     },
                        //     itemSubmitted: (item2) {
                        //       setState(() {
                        //         searchTextField2.textField.controller.text =
                        //             item2.buildKk;
                        //         print(
                        //             '---------------------------${item2.buildId}');
                        //         idBuilding = item2.buildId;
                        //       });
                        //     },
                        //     itemBuilder: (context, item2) {
                        //       // ui for the autocompelete row
                        //       return Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: rowbuilding(item2),
                        //       );
                        //     },
                        //   ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        'ชั้น : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: 150,
                        child: loadingss
                            ? LinearProgressIndicator(
                                color: Colors.teal[100],
                                minHeight: 10,
                              )
                            : DropdownButton(
                                value: selected2,
                                hint: Text('เลือกชั้น'),
                                items: data2.map((list) {
                                  return DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        Text('ชั้น ' + list['floorspp']),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        // Text(list['build_kk']),
                                      ],
                                    ),
                                    value: list['floorspp'].toString(),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selected2 = value;
                                    print('555555555555555555' + value);
                                  });
                                },
                              ),

                        // searchTextField3 =
                        //     AutoCompleteTextField<CateBuildingModel>(
                        //     controller: controllerFloor,
                        //     key: keyFloor,
                        //     clearOnSubmit: false,
                        //     suggestions: floors,
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16.0,
                        //     ),
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        //       hintText: "พิมพ์ค้นหาชั้นที่เกิดเหตุขัดข้อง",
                        //       hintStyle: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     itemFilter: (item, query) {
                        //       return item.floorspp
                        //           .toLowerCase()
                        //           .contains(query.toLowerCase());
                        //     },
                        //     itemSorter: (a, b) {
                        //       return a.floorspp.compareTo(b.floorspp);
                        //     },
                        //     itemSubmitted: (item3) {
                        //       setState(() {
                        //         searchTextField3.textField.controller.text =
                        //             item3.floorspp;
                        //         print(
                        //             '---------------------------${item3.buildId}');
                        //         idBuilding = item3.buildId;
                        //       });
                        //     },
                        //     itemBuilder: (context, item3) {
                        //       // ui for the autocompelete row
                        //       return Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: rowFloors(item3),
                        //       );
                        //     },
                        //   ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'ลำดับห้อง : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: 150,
                        child: loadingsss
                            ? LinearProgressIndicator(
                                color: Colors.teal[100],
                                minHeight: 10,
                              )
                            : DropdownButton(
                                value: selected3,
                                hint: Text('เลือกลำดับห้อง'),
                                items: data3.map((list) {
                                  return DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        Text('ลำดับห้อง ' + list['numRoom']),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        // Text(list['build_kk']),
                                      ],
                                    ),
                                    value: list['numRoom'].toString(),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selected3 = value;
                                    print('555555555555555555' + value);
                                  });
                                },
                              ),

                        // searchTextField4 =
                        //     AutoCompleteTextField<CateBuildingModel>(
                        //     controller: controllerRoom,
                        //     key: keyRoom,
                        //     clearOnSubmit: false,
                        //     suggestions: roomss,
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16.0,
                        //     ),
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        //       hintText:
                        //           "พิมพ์ค้นหาลำดับห้องที่เกิดเหตุขัดข้อง",
                        //       hintStyle: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     itemFilter: (item, query) {
                        //       return item.numRoom
                        //           .toLowerCase()
                        //           .contains(query.toLowerCase());
                        //     },
                        //     itemSorter: (a, b) {
                        //       return a.numRoom.compareTo(b.numRoom);
                        //     },
                        //     itemSubmitted: (item4) {
                        //       setState(() {
                        //         searchTextField4.textField.controller.text =
                        //             item4.numRoom;
                        //         print(
                        //             '---------------------------${item4.buildId}');
                        //         idBuilding = item4.buildId;
                        //       });
                        //     },
                        //     itemBuilder: (context, item4) {
                        //       // ui for the autocompelete row
                        //       return Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: rowRoom(item4),
                        //       );
                        //     },
                        //   ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  moreForm2(),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.teal,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {
                      if (selected == null &&
                          selected2 == null &&
                          selected3 == null &&
                          textEditController2.text == null) {
                        showAlert(
                            'คำเตือน!!!', 'กรุณาระบุสถานที่ที่เกิดเหตุขัดข้อง');
                      } else {
                        print(
                            '//////////////////////////////////////$idBuilding');
                        route(
                          Showlist1(
                            idHolder: controller.text,
                            idBuilding: idBuilding,
                            buildingName: selected,
                            floors: selected2,
                            rooms: selected3,
                            moreForm: textEditController2.text,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'เลือกสถานที่',
                      style:
                          TextStyle(fontFamily: 'Kanit', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              )
            ],
          );
        });
  }
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}
// 71186186