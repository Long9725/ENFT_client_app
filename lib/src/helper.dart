import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF041e42);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

Color getForegroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Color(0xFFffffff);
  }
  return Color(0xFFa0a0a0);
}

Color getBackgroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Color(0xFF82b6ff);
  }
  return primaryColor;
}

List<Map<String, String>> latLonMapWithSnailArray(int num, String latitude, String longitude) {
  List<Map<String, String>> latLonMap = List.generate(num*num, (_) => <String, String>{});
  // List<Map<String, String>> gpsMap = List.filled(num*num+1,  <String, String>{}, growable: true);
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
      latLonMap[index].addAll({'lat':lat.toString(), 'lon': longitude.toString()});
      index = index + 1;
    }
    num -= 1;
    if (num > 0) {
      for (int i = 0; i < num; i++) {
        col += swift; // 열은 고정, 행은 변화
        lon += 0.075 * swift;
        latLonMap[index].addAll({'lat':lat.toString(), 'lon': longitude.toString()});
        index = index + 1;
      }
      swift *= (-1); // 스위칭
    } else {
      break;
    }
  } while (true);

  return latLonMap;
}
