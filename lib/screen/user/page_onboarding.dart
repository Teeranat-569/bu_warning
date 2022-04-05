import 'package:app_bu/screen/user/login.dart';
import 'package:app_bu/utility/Constants.dart';
import 'package:app_bu/utility/LocalBindings.dart';
import 'package:app_bu/utility/colors.dart';
import 'package:app_bu/utility/dots_indicator.dart';
import 'package:app_bu/utility/intro_page.dart';
import 'package:app_bu/utility/responsive_screen.dart';
import 'package:flutter/material.dart';


class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _controller = PageController();
  bool leadingVisibility = false;
  Screen size;

  final List<Widget> _pages = [
    IntroPage("images/onboard_1.png", "แจ้งเหตุขัดข้อง",
        "ผู้ใช้สามารถแจ้งข้อมูลเหตุขัดข้องได้สะดวก เพียงแค่คลิกที่ไอคอนรูปโทรโข่ง"),
    IntroPage("images/onboard_2.png", "สถานะ",
        "ผู้ใช้แจ้งเหตุ กำลังดำเนินการ เสร็จสิ้น รีวิว"),
    IntroPage("images/onboard_3.png", "คะแนน",
        "ผ้ใช้สามารถให้คะแนนความพึงพอใจได้เมื่อซ่อมเสร็จสิ้น"),
  ];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    bool isLastPage = currentPageIndex == _pages.length - 1;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              pageViewFillWidget(),
              appBarWithButton(isLastPage, context),
              bottomDotsWidget()
            ],
          ),
        ));
  }

  Positioned bottomDotsWidget() {
    return Positioned(
        bottom: size.getWidthPx(20),
        left: 0.0,
        right: 0.0,
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          color: colorCurve,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ));
  }

  Positioned appBarWithButton(bool isLastPage, BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: new SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          primary: false,
          centerTitle: true,
          leading: Visibility(
              visible: leadingVisibility,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.animateToPage(currentPageIndex - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              )),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: size.getWidthPx(16),
                  right: size.getWidthPx(12),
                  bottom: size.getWidthPx(12)),
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.white,
                child: Text(
                  isLastPage ? 'DONE' : 'NEXT',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                onPressed: isLastPage
                    ? () async {
                        // Last Page Done Click

                        LocalStorage.sharedInstance
                            .writeValue(key: Constants.isOnBoard, value: "1");

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Authen()));
                      }
                    : () {
                        _controller.animateToPage(currentPageIndex + 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned pageViewFillWidget() {
    return Positioned.fill(
        child: PageView.builder(
      controller: _controller,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index % _pages.length];
      },
      onPageChanged: (int p) {
        setState(() {
          currentPageIndex = p;
          if (currentPageIndex == 0) {
            leadingVisibility = false;
          } else {
            leadingVisibility = true;
          }
        });
      },
    ));
  }
}
