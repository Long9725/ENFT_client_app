import 'package:blue/src/helper.dart';
import 'package:blue/src/service/klaytn_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  String requestKey = "none";
  String userKlipAddress = "none";

  getRequestAddress() async {
    requestKey = await RequestAddress();
    setState(() {});
  }

  getUserKlipAddress() async {
    requestKey = await RequestAddress();
    setState(() {});
    userKlipAddress = await getKlipAccessUrl("", requestKey);
    setState(() {});
    var a = await launch(userKlipAddress);
    print(a);
    // if (await canLaunch(userKlipAddress)) {
    //   print("h");
    //   await launch(userKlipAddress);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QrImage(
                      data: requestKey,
                    ),
                    Text(requestKey),
                    Text(userKlipAddress),
                    Container(
                        height: 56.0,
                        child: OutlinedButton(
                            onPressed: getUserKlipAddress,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff216FEA)),
                              foregroundColor: MaterialStateProperty.all(
                                Color(0xffffffff),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(kDefaultPadding / 2),
                                    child: SvgPicture.asset(
                                      'assets/logos/klip_logo.svg',
                                      height: 18.0,
                                      fit: BoxFit.fitWidth,
                                    )),
                                Text(
                                  "Klip으로 시작",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )))
                  ],
                ))));
  }
}
