import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const double kDefaultPadding = 16.0;
const MaterialColor kPrimaryColor = MaterialColor(
  0xff041e42, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0xff1d3555),//10%
    100: Color(0xff364b68),//20%
    200: Color(0xff4f627b),//30%
    300: Color(0xff68788e),//40%
    400: Color(0xff828fa1),//50%
    500: Color(0xff9ba5b3),//60%
    600: Color(0xffb4bcc6),//70%
    700: Color(0xffcdd2d9),//80%
    800: Color(0xffe6e9ec),//90%
    900: Color(0xffffffff),//100%
  },
);
const Color kErrorColor = Colors.red;
const Color kScaffoldBackgroundColor = Color(0xfcffffff);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

Color getForegroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return const Color(0xFFffffff);
  }
  return const Color(0xFFa0a0a0);
}

Color getBackgroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return const Color(0xFF82b6ff);
  }
  return kPrimaryColor;
}

List<Map<String, String>> latLonMapWithSnailArray(
    int num, String latitude, String longitude) {
  List<Map<String, String>> latLonMap =
      List.generate(num * num, (_) => <String, String>{});
  double lat = double.parse(latitude);
  double lon = double.parse(longitude);

  int index = 0;
  int swift = 1; // +는 행열의 증가, -는 행과 열의 감소
  int col = 1, row = 0;

  //[2] 처리
  do {
    for (int i = 0; i < num; i++) {
      row += swift; // 열은 변화, 행은 고정
      lat += 0.035 * swift;
      latLonMap[index]
          .addAll({'lat': lat.toString(), 'lon': longitude.toString()});
      index = index + 1;
    }
    num -= 1;
    if (num > 0) {
      for (int i = 0; i < num; i++) {
        col += swift; // 열은 고정, 행은 변화
        lon += 0.075 * swift;
        latLonMap[index]
            .addAll({'lat': lat.toString(), 'lon': longitude.toString()});
        index = index + 1;
      }
      swift *= (-1); // 스위칭
    } else {
      break;
    }
  } while (true);

  return latLonMap;
}

Future<List> fetchData(int num, String lat, String lon) async {
  List<String> address = [];
  List<Map<String, String>> gpsMap = latLonMapWithSnailArray(num, lat, lon);
  Map<String, String> headers = {
    "X-NCP-APIGW-API-KEY-ID": "",
    "X-NCP-APIGW-API-KEY": ""
  };

  String temp = "";

  for (int i = 0; i < gpsMap.length; i++) {
    http.Response response = await http.get(
        Uri.parse(
            "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${gpsMap[i]['lat']},${gpsMap[i]['lon']}&sourcecrs=epsg:4326&output=json"),
        headers: headers);

    String jsonData = response.body;

    var state = jsonDecode(jsonData)["results"][1]['region']['area1']['name'];
    var city = jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
    var town = jsonDecode(jsonData)["results"][1]['region']['area3']['name'];

    temp = state + " " + city + " " + town;

    if (address.contains(temp) == true) {
      continue;
    } else {
      address.add(temp);
    }
  }

  return address;
}

String distanceTimeFromNow(DateTime originDateTime) {
  String timeFromNow;
  DateTime now = DateTime.now();
  int distance;

  distance = DateTime(now.year, now.month, now.day, now.hour, now.minute)
      .difference(DateTime(originDateTime.year, originDateTime.month,
          originDateTime.day, originDateTime.hour, originDateTime.minute))
      .inMinutes;

  if (distance ~/ 60 != 0) {
    if (distance ~/ (60 * 24) != 0) {
      if (distance ~/ (60 * 24 * 30) != 0) {
        if (distance ~/ (60 * 24 * 365) != 0) {
          timeFromNow = (distance ~/ (60 * 24 * 365)).toString() + "년 전";
          return timeFromNow;
        }
        timeFromNow = (distance ~/ (60 * 24 * 30)).toString() + "달 전";
        return timeFromNow;
      }
      timeFromNow = (distance ~/ (60 * 24)).toString() + "일 전";
      return timeFromNow;
    }
    timeFromNow = (distance ~/ (60)).toString() + "시간 전";
    return timeFromNow;
  } else {
    timeFromNow = distance.toString() + "분 전";
  }
  return timeFromNow;
}

String currencyFormat(int price) {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);
  return formatCurrency.format(price) + "원";
}

