import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';

class FrontTicket extends StatelessWidget {
  const FrontTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Text("아주대학교 헬스장",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
            Icon(Icons.share, color: Colors.white)
          ],
        ),
        SizedBox(
          height: kDefaultPadding * 2,
        ),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        SizedBox(
          height: kDefaultPadding / 8,
        ),
      ],
    );
  }
}
