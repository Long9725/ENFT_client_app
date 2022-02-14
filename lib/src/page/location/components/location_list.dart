import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:blue/src/provider/location.dart';
import 'package:blue/src/page/sign_up/sign_up.dart';
import 'package:blue/src/widget/overlapped_circular_progress_indicator.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key, required this.isVisible}) : super(key: key);

  final bool isVisible;

  @override
  State<LocationList> createState() => LocationListState();
}

class LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "근처 동네",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Stack(children: [
          Visibility(
            visible: widget.isVisible,
            child: OverlappedCircularProgressIndicator(
                height: MediaQuery.of(context).size.height - 182,
                width: MediaQuery.of(context).size.width),
          ),
          ListView(shrinkWrap: true, children: <Widget>[
            for (var address in context.read<LocationProvider>().addressList)
              Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpPage(),
                            ));
                          },
                          style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              // <-- had to set alignment
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.all(
                                    0), // <-- had to set padding to 0
                              ),
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width - 32, 40))),
                          child: Text(address,
                              style: const TextStyle(color: Colors.black))),
                    ],
                  ),
                  const Divider(
                    height: 0,
                    thickness: 0.2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black45,
                  ),
                ],
              )
          ])
        ])
      ],
    );
  }
}
