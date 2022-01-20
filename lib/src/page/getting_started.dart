import 'dart:async';

import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'home.dart';
import 'loaction.dart';

import '../helper.dart';
import '../widget/slide_item.dart';
import '../widget/slide_dots.dart';
import '../model/slide.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
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
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index)  {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double belowSlideDotsHeight = 102.0; // 96+6
    double pageViewHeight = 326.0; // 200 + 16*2 + 24 + 16 + 18*3
    double paddingSlideDotsFromBtn = (height - (belowSlideDotsHeight+pageViewHeight+kDefaultPadding*2)) / 4;

    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Padding(
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
                    OutlinedButton(
                      child: const Text("Getting Started"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage(title: "blue"),
                        ));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(const Color(0xFFF0F0F0)),
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              Location location = Location();

                              bool _serviceEnabled;
                              PermissionStatus _permissionGranted;
                              LocationData _locationData;

                              _serviceEnabled = await location.serviceEnabled();
                              if (!_serviceEnabled) {
                                _serviceEnabled = await location.requestService();
                                if (!_serviceEnabled) {
                                  return;
                                }
                              }

                              _permissionGranted = await location.hasPermission();
                              if (_permissionGranted == PermissionStatus.denied) {
                                _permissionGranted = await location.requestPermission();
                                if (_permissionGranted != PermissionStatus.granted) {
                                  return;
                                }
                              }

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LocationPage(),
                              ));
                            },
                            child: const Text("Login")),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
