import 'package:flutter/material.dart';

import '../helper.dart';
import '../widget/list_item.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {}

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
                        onPressed: () {},
                        child: Text('현재 위치로 찾기',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
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
                      Expanded(
                        child: ListView(shrinkWrap: true, children: <Widget>[
                          for (int i = 0; i < 20; i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            alignment: Alignment.centerLeft,
                                            // <-- had to set alignment
                                            padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                              const EdgeInsets.all(
                                                  0), // <-- had to set padding to 0
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all(Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        32,
                                                    40))),
                                        child: Text("경기도 화성시 기산동",
                                        style: TextStyle(color: Colors.black))),
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
                      )
                    ]))));
  }
}
