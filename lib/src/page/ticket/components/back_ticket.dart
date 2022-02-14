import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

class BackTicket extends StatelessWidget {
  const BackTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(child: buildColumnTextItem("등록날짜", "2022.02.09", false)),
          buildColumnTextItem("만료날짜", "2022.08.09", false),
        ],
      ),
      SizedBox(
        height: kDefaultPadding * 2,
      ),
      buildColumnTextItem("남은기간", "D+180", true),
      SizedBox(
        height: kDefaultPadding * 3,
      ),
    ]);
  }

  Widget buildColumnTextItem(String title, String text, bool isBool) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        const SizedBox(
          height: kDefaultPadding / 4,
          width: 0,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              fontSize: isBool ? 30.0 : 16.0,
              color: Colors.white),
        )
      ],
    );
  }
}
