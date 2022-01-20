import 'package:blue/src/widget/overlapped_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/page/sign_up_with_phone_number.dart';
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
  bool _isVisible = false;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tempList.isEmpty == true) _tempList = context.read<LocationProvider>().addressList;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
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
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          _isVisible = true;
                          setState(() {
                            _isVisible = true;
                          });
                          LocationData _locationData;
                          _locationData = await location.getLocation();
                          context.read<LocationProvider>().addressList =
                              await fetchData(5, _locationData.longitude.toString(), _locationData.latitude.toString());
                          setState(() {
                            _tempList = context.read<LocationProvider>().addressList;
                            _isVisible = false;
                          });
                        },
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
                          foregroundColor: MaterialStateProperty.resolveWith(
                              getForegroundColor),
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "근처 동네",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Stack(children: [
                          Visibility(
                            visible: _isVisible,
                            child: OverlappedCircularProgressIndicator(
                                height:
                                    MediaQuery.of(context).size.height - 182,
                                width: MediaQuery.of(context).size.width),
                          ),
                          ListView(shrinkWrap: true, children: <Widget>[
                            for (var address
                                in context.read<LocationProvider>().addressList)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpWithPhoneNumberPage(),
                                            ));
                                          },
                                          style: ButtonStyle(
                                              alignment: Alignment.centerLeft,
                                              // <-- had to set alignment
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                const EdgeInsets.all(
                                                    0), // <-- had to set padding to 0
                                              ),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              32,
                                                          40))),
                                          child: Text(address,
                                              style: const TextStyle(
                                                  color: Colors.black))),
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
                        ]),
                      )
                    ]))));
  }
}
