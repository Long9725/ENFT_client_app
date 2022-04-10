import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import 'package:blue/src/page/wallet/components/klip_login_button.dart';
import 'package:blue/src/page/wallet/components/menu.dart';
import 'package:blue/src/page/wallet/components/transaction.dart';
import 'package:blue/src/page/wallet/components/wallet_card.dart';

import 'package:blue/src/api/klaytn.dart';
import 'package:blue/src/api/klip.dart';
import 'package:blue/src/helper.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  KlipApi klipApi = KlipApi();
  KlaytnApi klaytnApi = KlaytnApi();
  late Timer _timer;
  String balance = '0';

  @override
  void initState() {
    // TODO: implement initState
    klipApi.initKlipApi();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    String status;
    int time = 0;
    int timeout = 120;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (time >= timeout) _pause();
      status = await klipApi.getKlipAddress();
      if (status != 'progress') {
        _pause();
        getBalance();
      }
      time += 5;
    });
  }

  void _pause() {
    _timer.cancel();
  }

  void getKlipAddress() {
    if (klipApi.getUserKlipAddress.isEmpty) {
      if (Platform.isAndroid) {
        klipApi.createIntent().whenComplete(() => _start());
      } else {
        klipApi.createDeepLink().whenComplete(() => _start());
      }
    }
  }

  void getBalance() async {
    if (klipApi.getUserKlipAddress.isNotEmpty) {
      balance = await klaytnApi.getBalance(klipApi.getUserKlipAddress);
      print(balance);
      setState(() {});
    }
  }

  void getNFT() async {
    final address = klipApi.getUserKlipAddress;
    Uri uri = Uri.parse(dotenv.env["SERVER_ADDRESS"]!+'/user/mynft?address=$address');
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final http.Response response = await http.get(uri, headers: headers);
    final body = Map<String, dynamic>.from(json.decode(response.body));
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(klipApi.getRequestKey),
                // Text(klipApi.getUserKlipAddress),
                // Text(klipApi.priceKlay.toString()),
                // Text(balance.toString()),
                WalletCard(
                    klaytnBalance: double.parse(balance),
                    klaytnPrice: klipApi.priceKlay,
                    receiveKlay: getBalance,
                    sendKlay: getBalance),
                // const SizedBox(height: 16),
                // Menu(),
                // const SizedBox(height: 16),
                // Expanded(child: Transaction())
                const SizedBox(height: 16),
                KlipLoginButton(onPressed: getKlipAddress),
                // const SizedBox(height: 16),
                // OutlinedButton(onPressed: getBalance, child: Text("getBalance"))
              ],
            )));
  }
}
