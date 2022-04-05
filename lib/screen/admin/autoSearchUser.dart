import 'dart:io';

import 'package:app_bu/models/user_models.dart';
import 'package:app_bu/screen/admin/dataUser.dart';
import 'package:app_bu/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:overlay_support/overlay_support.dart';

class AutoCompleteDemoUser extends StatefulWidget {
  AutoCompleteDemoUser() : super();

  final String title = "ข้อมูลผู้ใช้";

  @override
  _AutoCompleteDemoUserState createState() => _AutoCompleteDemoUserState();
}

class _AutoCompleteDemoUserState extends State<AutoCompleteDemoUser> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<UserModel>> key = new GlobalKey();
  // ignore: deprecated_member_use
  static List<UserModel> users = new List<UserModel>();
  bool loading = true;
  TextEditingController controller = TextEditingController();
  // ignore: deprecated_member_use
  List<UserModel> userModels = List();
  // ignore: deprecated_member_use
  List<UserModel> filterUserModels = List();
  // ignore: unused_field
  ListItem _selectedItem;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem userModel;
  String idUser;

  @override
  void initState() {
    getUsers();
    showRate();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
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

  void getUsers() async {
    try {
      final response =
          await http.get("${Myconstant().domain}/appkk/getAllUser.php");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<UserModel> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }

  bool loadStatus = true;
  bool status = true;

  Future<Null> showRate() async {
    String url = '${Myconstant().domain}/appkk/getAllBuilding.php';
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
            UserModel rateModel = UserModel.fromJson(map);

            userModels.add(rateModel);
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
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 5,
          );
        },
        padding: EdgeInsets.only(top: 7),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: filterUserModels.length,
        itemBuilder: (context, index) {
          // ignore: deprecated_member_use
          return FlatButton(
            onPressed: () {},
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  width: 230,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${filterUserModels[index].name}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ])),
            ]),
          );
        });
  }

  List<ListItem> _dropdownItems = [
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

  Widget row(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.name,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Future<Null> route(Widget routeName) async {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => routeName);
    Navigator.of(context).push(materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.orange,
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Kanit'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: Cross,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              loading
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          searchTextField = AutoCompleteTextField<UserModel>(
                            controller: controller,
                            key: key,
                            clearOnSubmit: false,
                            suggestions: users,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              enabledBorder: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              hintText: "พิมพ์ค้นหาชื่อและนามสกุล",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            itemFilter: (item, query) {
                              return item.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.name.compareTo(b.name);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text =
                                    item.name;
                                print('---------------------------${item.id}');
                                idUser = item.id;
                              });
                            },
                            itemBuilder: (context, item) {
                              // ui for the autocompelete row
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: row(item),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              // ignore: deprecated_member_use
              SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.orange[600],
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {
                  print('//////////////////////////////////////$idUser');
                  route(
                    Datauser(
                      idHolder: controller.text,
                      idBuilding: idUser,
                    ),
                  );
                },
                child: Text(
                  'ตรวจสอบข้อมูลผู้ใช้',
                  style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
