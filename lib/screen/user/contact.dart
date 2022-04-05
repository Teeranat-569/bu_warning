import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowlistContact extends StatefulWidget {
  @override
  _ShowlistContactState createState() => _ShowlistContactState();
}

class _ShowlistContactState extends State<ShowlistContact> {
 
 @override
  void initState() {
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
              Text("โปรดดูที่รายการแจ้งเหตุ",style: TextStyle(fontSize: 14),),
            ],
          ),
         
          background: Colors.yellow[900],
        );
        
      });
    } else if (Platform.isIOS) {
      print('About Noti Work........IOS');
    }
  }

 
  Widget showGrid() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      childAspectRatio: 16 / 9,
      children: <Widget>[
        // ignore: deprecated_member_use
        RaisedButton(
            onPressed: () {
              print('Facebook');
              _launchURLFace();
            },
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Icon(Icons.face),
                Image.asset(
                  'images/Facebook_Logo.png',
                  height: 100.0,
                ),
                const Text(
                  "Facebook : ",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "กองอาคารสถานที่และสิ่งแวดล้อม",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        // ignore: deprecated_member_use
        RaisedButton(
            onPressed: () {
              print('Web');
              _launchURLWeb();
            },
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Icon(Icons.pageview, size: 100, color: Colors.pink[800]),
                const Text(
                  "Web site",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Text(
                  "กองอาคารสถานที่และสิ่งแวดล้อม",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
      ],
    );
  }

  Future _launchURLFace() async {
    const url = 'https://www.facebook.com/bsrubuilding/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _launchURLWeb() async {
    const url = 'http://building.bsru.ac.th/ ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('ช่องทางการติดตาม')),
      ),
      body: Container(
        child: showGrid(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/contact.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
