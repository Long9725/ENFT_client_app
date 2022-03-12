import 'dart:io';

import 'package:blue/src/page/wallet/components/klip_login_button.dart';
import 'package:blue/src/page/wallet/components/menu.dart';
import 'package:blue/src/page/wallet/components/transaction.dart';
import 'package:blue/src/page/wallet/components/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int balance = 100;

  @override
  void initState() {
    // TODO: implement initState
    klipApi.initKlipApi();
    super.initState();
  }

  void getKlipAddress() {
    if (klipApi.getUserKlipAddress.isEmpty) {
      if (Platform.isAndroid) {
        klipApi.createIntent().whenComplete(
            () => klipApi.getKlipAddress().whenComplete(() => setState(() {})));
      } else {
        klipApi.createDeepLink().whenComplete(
            () => klipApi.getKlipAddress().whenComplete(() => setState(() {})));
      }
    }
  }

  void getBalance() async {
    if (klipApi.getUserKlipAddress.isNotEmpty) {
      await klaytnApi.getBalance(klipApi.getUserKlipAddress);
    }
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
                    klaytnBalance: 11123.123123,
                    klaytnPrice: klipApi.priceKlay,
                    receiveKlay: getBalance,
                    sendKlay: getBalance),
                const SizedBox(height: 16),
                Menu(),
                const SizedBox(height: 16),
                Expanded(child: Transaction())
                // const SizedBox(height: 16),
                // KlipLoginButton(onPressed: getKlipAddress),
                // const SizedBox(height: 16),
                // OutlinedButton(onPressed: getBalance, child: Text("getBalance"))
              ],
            )));
  }
}
