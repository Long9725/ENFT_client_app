import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:blue/src/helper.dart';

class QRCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("전자출입\nQR  코드",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold)),
                Text("오늘도 안전한\n편리한 헬스장",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
              ],
            )),
            QrImage(
              data: "https://www.naver.com",
              backgroundColor: Colors.white,
              size: 125,
            )
          ],
        ),
        SizedBox(
          height: kDefaultPadding / 8,
        ),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        SizedBox(
          height: kDefaultPadding / 3,
        ),
      ],
    );
  }
}
