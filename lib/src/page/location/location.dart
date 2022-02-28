import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/page/location/components/body.dart';
import 'package:blue/src/provider/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _textEditingController = TextEditingController();
  var location = Location();
  List _tempList = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tempList.isEmpty == true)
      _tempList = context.read<LocationProvider>().addressList;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(appBar: buildAppBar(), body: Body()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: TextField(
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          if (value == "") {
            context.read<LocationProvider>().addressList = _tempList;
            return;
          }
          List tempList = [];
          for (var address in context.read<LocationProvider>().addressList) {
            if (address.contains(value) == true) tempList.add(address);
          }
          context.read<LocationProvider>().addressList = tempList;
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: '지역을 입력해주세요. (동명(읍,면)으로 검색)',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12)),
        ),
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
