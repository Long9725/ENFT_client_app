import 'dart:convert';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

// Klip App2App api for flutter
// 3 Steps: Prepare -> Request -> Result
class KlipApi {
  String requestKey = "";
  String userKlipAddress = "";
  final prepareUri = Uri.parse('https://a2a-api.klipwallet.com/v2/a2a/prepare');
  Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json'
  };

  KlipApi() {
    getRequestKey();
  }

  // Prepare api
  // Get request key for klip App2App api
  Future<String> getRequestKey() async {
    String body = jsonEncode(<String, dynamic>{
      'bapp': {'name': 'My BApp'},
      'callback': {
        'success': 'mybapp://klipwallet/success',
        'fail': 'mybapp://klipwallet/fail'
      },
      'type': 'auth'
    });

    final http.Response response =
        await http.post(prepareUri, body: body, headers: headers);
    final responseBody = Map<String, dynamic>.from(json.decode(response.body));

    return responseBody['request_key'].toString();
  }

  // Send klay to another user
  Future<String> sendKlay(String to, String amount) async {
    if (userKlipAddress == "") {
      print('Error sending klay: no klip address');
      return '';
    }
    String body = jsonEncode(<String, dynamic>{
      'transaction': {'from': userKlipAddress, 'to': to, 'amount': amount}
    });

    final http.Response response =
        await http.post(prepareUri, body: body, headers: headers);
    final responseBody = Map<String, dynamic>.from(json.decode(response.body));
    print(responseBody);

    return 'success';
  }

  // Send NFT card to another user
  Future<String> sendCard(String contract, String to, String cardId) async {
    if (userKlipAddress == "") {
      print('Error sending card: no klip address');
      return '';
    }

    String body = jsonEncode(<String, dynamic>{
      'transaction': {
        'contract': contract,
        'from': userKlipAddress,
        'to': to,
        'card_id': cardId
      }
    });

    final http.Response response =
        await http.post(prepareUri, body: body, headers: headers);
    final responseBody = Map<String, dynamic>.from(json.decode(response.body));
    print(responseBody);

    return 'success';
  }

  // Request api
  // if set deep link, back to BApp
  // Get user klip address(EOA) to BApp

  // android verification api
  void createIntent() async {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(
            'kakaotalk://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$requestKey#Intent;scheme=kakaotalk;package=com.kakao.talk;end'),
        package: 'com.kakao.talk');
    await intent.launch();
  }

  // iOS verification api
  void createDeepLink() async {
    String uri =
        "kakaotalk://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$requestKey";
    if (await canLaunch(uri)) {
      print("Deeplink can launch.");
      await launch(uri);
    } else {
      print("Error: Deeplink can't launch.");
    }
  }

  // Result api
  // Get user klip address
  // Status : completed, canceled, error, prepare, requested
  Future<String> getKlipAddress() async {
    Uri uri = Uri.parse(
        'https://a2a-api.klipwallet.com/v2/a2a/result?request_key=$requestKey');

    final http.Response response = await http.get(uri, headers: headers);
    final body = Map<String, dynamic>.from(json.decode(response.body));

    if (body['status'].toString() == 'completed') {
      final result = Map<String, String>.from(body['result']);
      print('Get user klip address: ' + result['klaytn_address'].toString());
      userKlipAddress = result['klaytn_address'].toString();
      return 'completed';
    } else if (body['status'].toString() == 'canceled') {
      print('User cancel request');
      return 'canceled';
    } else if (body['status'].toString() == 'error') {
      print('Error getting klip address');
      return 'error';
    } else {
      print('Request in progress');
      return 'progress';
    }
  }

  // Get user permission from native
  Future getUserPermission() async {
    const platform = MethodChannel('com.example.blue/klip');

    requestKey = await getRequestKey();
    try {
      await platform.invokeMethod(
        'getUserPermission',
        <String, dynamic>{'requestKey': requestKey},
      ).then((result) async {
        print('User klip permission: $result');
      });
    } on PlatformException catch (e) {
      String message = e.message ?? "";
      print('Error on user permission: $message');
    }
  }

  // Get klay price from bithumb api
  // https://www.bithumb.com/trade/order/KLAY_KRW
  Future<int> getKlayKRWPriceFromBithumb() async {
    Uri request = Uri.parse('https://api.bithumb.com/public/ticker/KLAY_KRW');

    final http.Response response = await http.get(
      request,
    );

    final body = Map<String, dynamic>.from(json.decode(response.body));

    return int.parse(body['data']['closing_price']);
  }
}
