import 'dart:async';

import 'package:blue/src/page/home.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/Slide.dart';
import 'package:blue/src/page/location.dart';
import 'package:blue/src/provider/location.dart';
import 'package:blue/src/widget/slide_item.dart';
import 'package:blue/src/widget/slide_dots.dart';
import 'package:blue/src/widget/overlapped_circular_progress_indicator.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  bool _isVisible = false;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
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
              Expanded(
                  child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (context, index) => SlideItem(index)),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < slideList.length; i++)
                            if (i == _currentPage)
                              const SlideDots(true)
                            else
                              const SlideDots(false)
                        ],
                      )
                    ],
                  )
                ],
              )),
              SizedBox(height: paddingSlideDotsFromBtn),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      child: const Text(
                        "시작하기",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
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
                          _permissionGranted =
                              await location.requestPermission();
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
                          context.read<LocationProvider>().addressList =
                              (await fetchData(
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
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xFFF0F0F0)),
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "이미 계정이 있나요?",
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () async {
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
                              _permissionGranted =
                                  await location.requestPermission();
                              if (_permissionGranted !=
                                  PermissionStatus.granted) {
                                setState(() {
                                  _isVisible = false;
                                });
                                return;
                              }
                            }

                            LocationData _locationData;
                            _locationData = await location.getLocation();

                            try {
                              context.read<LocationProvider>().addressList =
                                  await fetchData(
                                      5,
                                      _locationData.longitude.toString(),
                                      _locationData.latitude.toString());
                            } catch (e) {
                              print(e);
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
                          },
                          child: const Text(
                            "로그인",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              )
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
