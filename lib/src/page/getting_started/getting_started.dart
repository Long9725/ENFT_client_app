import 'dart:async';

import 'package:blue/src/page/getting_started/components/login_field.dart';
import 'package:blue/src/page/getting_started/components/started_page_view.dart';
import 'package:blue/src/page/home.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/Slide.dart';
import 'package:blue/src/page/location.dart';
import 'package:blue/src/provider/location.dart';
import 'package:blue/src/page/getting_started/components/slide_item.dart';
import 'package:blue/src/page/getting_started/components/slide_dots.dart';
import 'package:blue/src/widget/overlapped_circular_progress_indicator.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  bool _isVisible = false;

  Future<void> accessLocation() async {
    setState(() {
      _isVisible = true;
    });
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _isVisible = false;
        });
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          _isVisible = false;
        });
        return;
      }
    }

    LocationData _locationData;
    _locationData = await location.getLocation();

    try {
      context.read<LocationProvider>().addressList = (await fetchData(
          5,
          _locationData.longitude.toString(),
          _locationData.latitude.toString()));
    } catch (e) {
      setState(() {
        _isVisible = false;
      });
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LocationPage(),
    ));
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double belowSlideDotsHeight = 94.0; // 88+6
    double pageViewHeight = 304.0; // 200 + 16*2 + 24 + 16 + 16*2
    double paddingSlideDotsFromBtn = (height -
            (belowSlideDotsHeight + pageViewHeight + kDefaultPadding * 2)) /
        4;

    return Scaffold(
      body: Stack(children: [
        Visibility(
          visible: _isVisible,
          child:
              OverlappedCircularProgressIndicator(height: height, width: width),
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: <Widget>[
              Expanded(child: StartedPageView()),
              SizedBox(height: paddingSlideDotsFromBtn),
              LoginField(press: accessLocation)
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePage(title: "")));
        },
      ),
    );
  }
}