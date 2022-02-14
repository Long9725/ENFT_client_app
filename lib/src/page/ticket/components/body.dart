import 'package:flutter/material.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/ticket/components/flip_card.dart';
import 'package:blue/src/page/ticket/components/ticket.dart';
import 'package:blue/src/page/ticket/components/front_ticket.dart';
import 'package:blue/src/page/ticket/components/back_ticket.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> with TickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _selectedIndex = 0;
  var _currPageValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Page controller
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    final height = width * 1.618;

    return Center(
        child: SizedBox(
            height: height,
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return FlipCard(
                    controller: FlipCardController(),
                    front: Ticket(
                      description: FrontTicket(),
                      currPageValue: _currPageValue,
                      index: index,
                    ),
                    back: Ticket(
                      description: BackTicket(),
                      currPageValue: _currPageValue,
                      index: index,
                    ),
                  );
                })));
  }
}
