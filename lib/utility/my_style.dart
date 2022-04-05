import 'package:flutter/material.dart';

class MyStyle {
  Color darkcolor = Colors.indigo;

  SizedBox mySizedBox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showtitle(String title) => Text(
        title,
        style: TextStyle(fontSize: 30.0),
      );

  Container showLogo() {
    return Container(
      child: Image.asset(
        'images/megaphone.png',
        width: 150.0,
        height: 150.0,
      ),
    );
  }

  Container showLogo2() {
    return Container(
      child: Image.asset(
        'images/technician.png',
        width: 150.0,
        height: 150.0,
      ),
    );
  }

  Widget showProgress(Color color) {
    return Center(
      child: CircularProgressIndicator(color: color,),
    );
  }

  Widget showProgressMTN() {
    return Center(
      child: CircularProgressIndicator(color: Colors.blue,),
    );
  }

  SizedBox sizedBox20() {
    return SizedBox(
      height: 20.0,
    );
  }

  SizedBox sizedBox10() {
    return SizedBox(
      height: 10.0,
    );
  }

  TextStyle textStyle() => TextStyle(color: Colors.red);
  TextStyle textStyled() => TextStyle(fontSize: 16);

  MyStyle();
}
