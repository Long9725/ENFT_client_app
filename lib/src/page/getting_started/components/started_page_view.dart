import 'dart:async';

import 'package:flutter/material.dart';

import 'package:blue/src/model/Slide.dart';
import 'package:blue/src/page/getting_started/components/slide_dots.dart';
import 'package:blue/src/page/getting_started/components/slide_item.dart';

class StartedPageView extends StatefulWidget {
  @override
  State<StartedPageView> createState() => StartedPageViewState();
}

class StartedPageViewState extends State<StartedPageView> {
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
    return Stack(
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
    );
  }
}