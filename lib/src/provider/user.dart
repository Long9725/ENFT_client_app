import 'dart:convert';

import 'package:blue/src/provider/sqflite.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:blue/src/model/User.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  late User user;
  Map<String, dynamic> registerJson = {
    'nickname': '',
    'address': '',
    'location': '경기도 화성시',
    'sex': '',
    'profile': '',
  };
  bool login = false;

  UserProvider();

  Future<void> fetchUser(List<Map<String, dynamic>> maps) async {
    print(maps);
    if (maps.isEmpty) return;

    final uri = Uri.parse(dotenv.env['SERVER_ADDRESS']!);
    Map<String, dynamic> body = maps[0];
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };

    final http.Response response =
        await http.post(uri, body: body, headers: headers);

    final responseBody = Map<String, dynamic>.from(json.decode(response.body));

    if (responseBody['status'] != '200') return;

    final userMap = responseBody.remove('status');
    user = User.fromJson(userMap);
    login = true;
  }

  Future<void> register(BuildContext context) async {
    final uri =
        Uri.parse(dotenv.env['SERVER_ADDRESS']! + ":3000/auth/user/register");

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final body = json.encode(registerJson);
    print(body);
    final http.Response response =
        await http.post(uri, body: body, headers: headers);
    // await http.post(uri, body: registerUSer.toJson(), headers: headers);

    print(response.body);
    final responseBody = Map<String, dynamic>.from(json.decode(response.body));

    if (responseBody['status'] != '200') return;

    final temp = registerJson;
    temp['jwtToken'] = "none";

    final hashedPassword = DBCrypt().hashpw(responseBody['privateKEy'], '10');
    final Map<String, dynamic> data = {
      'address': registerJson['address'],
      'privateKey': hashedPassword,
    };

    context.read<SqfliteProvider>().insert('user', data);
    user = User.fromJson(temp);
    login = true;
  }
}
