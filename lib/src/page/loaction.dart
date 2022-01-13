import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../helper.dart';
import '../widget/list_item.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController _textEditingController = TextEditingController();
  var location = new Location();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  Future<List> fetchData(int num, String lat, String lon) async {
    List<String> address = [];
    List<Map<String, String>> gpsMap = latLonMapWithSnailArray(num, lat, lon);
    Map<String, String> headers = {
      "X-NCP-APIGW-API-KEY-ID": "",
      "X-NCP-APIGW-API-KEY": ""
    };

    String temp = "";
    int index = 0;
    for (int i = 0; i < gpsMap.length; i++) {
      http.Response response = await http.get(
          Uri.parse(
              "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${gpsMap[i]['lon']},${gpsMap[i]['lat']}&sourcecrs=epsg:4326&output=json"),
          headers: headers);

      String jsonData = response.body;

      var state = jsonDecode(jsonData)["results"][1]['region']['area1']['name'];
      var city = jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
      var town = jsonDecode(jsonData)["results"][1]['region']['area3']['name'];

      temp = state + " " + city + " " + town;

      if(address.contains(temp) == true) continue;
      else address.add(temp);
    }

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: TextField(
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
                        child: Text(
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
                              MaterialStateProperty.all(primaryColor),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "근처 동네",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                          future: fetchData(5, "37.541", "126.976"),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Error: ${snapshot.error}',
                                    style: TextStyle(fontSize: 15)),
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
                                                    style: TextStyle(
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
