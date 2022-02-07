import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:blue/src/helper.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => TicketScreenState();
}

class TicketScreenState extends State<TicketScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: SizedBox(
      height: (width - 80) * 1.618,
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: PageController(viewportFraction: 0.8),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          var _scale = _selectedIndex == index ? 1.0 : 0.8;
          return TweenAnimationBuilder(
              tween: Tween(begin: _scale, end: _scale),
              duration: const Duration(milliseconds: 350),
              curve: Curves.ease,
              child: buildCard(),
              builder: (context, value, child) {
                return Transform.scale(scale: value as double, child: child);
              });
        },
      ),
    )));
  }

  Widget buildCard() {
    return Card(
        elevation: kDefaultPadding,
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding, horizontal: kDefaultPadding * 2),
                child: Text(
                  "ENFT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0
                  ),
                )),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                            horizontal: kDefaultPadding * 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ENFT\n헬스장 이용권",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: kDefaultPadding / 2,
                            ),
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.white),
                                SizedBox(
                                  height: 0,
                                  width: kDefaultPadding / 2,
                                ),
                                Expanded(
                                    child: Text("헬스장 이름",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                                Icon(Icons.share, color: Colors.white)
                              ],
                            )
                          ],
                        )))),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0))),
                child: Wrap(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                          horizontal: kDefaultPadding * 2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child:
                                    buildColumnTextItem('남은일수', 'D+180', true)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildColumnTextItem('성명', '장성호', false),
                                const SizedBox(
                                    height: kDefaultPadding, width: 0),
                                buildColumnTextItem('등록날짜', '2022.01.30', false)
                              ],
                            )
                          ]))
                ]))
          ],
        ));
  }

  Widget buildColumnTextItem(String title, String text, bool isBool) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        const SizedBox(
          height: kDefaultPadding / 4,
          width: 0,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              fontSize: isBool ? 26.0 : 14.0),
        )
      ],
    );
  }
}
