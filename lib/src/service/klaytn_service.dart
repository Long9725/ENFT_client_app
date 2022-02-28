import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:http/http.dart' as http;

// Klaytn API Service
const String COUNT_CONTRACT_ADDRESS = "";
const String ACCESS_KEY_ID = "";
const String SECRET_ACCESS_KEY = "";
const String CHAIN_ID = "";

// Smart contract에서 abi 다운로드한 후, remove line breaks를 통해 한 줄로 만들기
const COUNT_ABI = "";

const option = {
  'headers': [
    {
      'name': "Authorization",
      'value': "Basic ${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY}"
    },
    {'name': "x-chain-id", 'value': CHAIN_ID}
  ]
};

// "https://node-api.klaytnapi.com/v1/klaytn"

// COUNT_ABI json 파싱 후에 COUNT_CONTRACT_ADDRESS랑 연결

// getBalance(address)로 Klaytn 지갑 잔고 가져오기

// setCount(newCount)로 Klaytn 지갑 새로 설정
// 사용할 account 설정
// 스마트 컨트랙트 실행 트랜잭션 날리기
// 결과 확인

// Klip API
// Prepare => Request => Result
Future RequestAddress() async {
  // Auth request
  // Return => request_key, status, expiration_time
  String authRequestUrl = "https://a2a-api.klipwallet.com/v2/a2a/prepare";
  String resultRequestUrl =
      "https://a2a-api.klipwallet.com/v2/a2a/result?request_key=";

  Map<String, dynamic> authBody = {
    'bapp': {'name': "KLAY_MARKET"},
    'type': "auth"
  };

  http.Response authResponse = await http.post(Uri.parse(authRequestUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: json.encode(authBody));

  String authJsonData = authResponse.body;
  // Result
  http.Response resultResponse = await http.get(Uri.parse(
      resultRequestUrl + "${jsonDecode(authJsonData)['request_key']}"));
  String resultKey = jsonDecode(resultResponse.body)['request_key'];
  return resultKey;
}

Future getKlipAccessUrl(String method, String request_key) async {
  if (Platform.isAndroid) {
    // AndroidIntent intent = AndroidIntent(
    //   action: 'action_view',
    //   data:
    //   "https://klipwallet.com/?target=/a2a?request_key=$request_key",
    //   package: 'com.kakao.talk',
    // );
    // AndroidIntent intent = AndroidIntent(
    //     action: 'action_view',
    //     data: "https://play.google.com/store/apps/details?id=com.kakao.talk",);
    return 'https://klipwallet.com/?target=/a2a?request_key=$request_key';
    print('https://klipwallet.com/?target=/a2a?request_key=$request_key');
    AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('https://klipwallet.com/?target=/a2a?request_key=$request_key'),
        package: 'com.android.chrome');
    await intent.launch();
    // print(intent.data);
    // await intent.launch();
    // print(
    //     "intent://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$request_key#Intent;scheme=kakaotalk;package=com.kakao.talk;end");
    // return "intent://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$request_key#Intent;scheme=kakaotalk;package=com.kakao.talk;end";
  } else if (Platform.isIOS) {
    return "kakaotalk://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$request_key";
  } else {
    return "kakaotalk://klipwallet/open?url=https://klipwallet.com/?target=/a2a?request_key=$request_key";
  }
}
