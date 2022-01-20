import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../helper.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _textEditingController = TextEditingController();
  var location = Location();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: const TextField(
                decoration: InputDecoration(
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
                          LocationData _locationData;
                          _locationData = await location.getLocation();
                          // fetchData(_locationData.latitude.toString(), _locationData.longitude.toString());
                          // setState(() async {
                          //   addresses = await fetchData(5, "37.541", "126.976");
                          // });
                          // latLonMapWithSnailArray(5, "37.541", "126.976");
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
                      FutureBuilder(
                          future: fetchData(5, "37.541", "126.976"),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return const Expanded(child: Center(child: CircularProgressIndicator()));
                            } else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Error: ${snapshot.error}',
                                    style: const TextStyle(fontSize: 15)),
                              );
                            } else {
                              return Expanded(
                                child: ListView(shrinkWrap: true, children: <
                                    Widget>[
                                  for (var address in snapshot.data)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // <-- had to set alignment
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      const EdgeInsets.all(
                                                          0), // <-- had to set padding to 0
                                                    ),
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size(
                                                                MediaQuery.of(
                                                                            context)
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
                                ]),
                              );
                            }
                          })
                    ]))));
  }
}
