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
  bool _isObscure = true;
  bool? _isChecked = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        Container(
                            // margin: const EdgeInsets.only(bottom: 5),
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < slideList.length; i++)
                              if (i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ))
                      ],
                    )
                  ],
                )),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlinedButton(
                      child: const Text("Getting Started"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(title: "blue"),
                        ));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith(
                            getForegroundColor),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              Location location = new Location();

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
                            child: Text("Login")),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'login',
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => HomePage(title: widget.title)),
      //     );
      //   },
      //   child: Icon(Icons.navigation),
      // ),
    );
  }
}
