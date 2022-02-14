import 'package:blue/src/widget/loading_hud.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/provider/location.dart';

import 'location_list.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  var location = Location();
  late LoadingHud hud;

  @override
  void initState() {
    hud = LoadingHud(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildLocationBtn(),
              Expanded(child: LocationList())
            ]));
  }

  OutlinedButton buildLocationBtn() {
    Future<void> getLocation() async {
      FocusScope.of(context).unfocus();
      hud.showHud();
      LocationData _locationData;
      _locationData = await location.getLocation();
      context.read<LocationProvider>().addressList = await fetchData(
          5,
          _locationData.longitude.toString(),
          _locationData.latitude.toString());
      hud.hideHud();
    }

    return OutlinedButton(
      onPressed: getLocation,
      child: const Text(
        '현재 위치로 찾기',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
      ),
    );
  }
}
