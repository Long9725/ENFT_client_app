import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String nickName;
  final String location;
  final String profile;

  User({required this.name, required this.nickName, required this.location, this.profile='assets/photos/basic-profile.jpg'});
}

final userList = [
  User(name: "강선규", nickName: "strong_sun9", location: "경기도 수원시"),
  User(name: "문민수", nickName: "mmin_goo", location: "경기도 수원시"),
  User(name: "배해진", nickName: "예능퀸", location: "경기도 수원시"),
  User(name: "장성호", nickName: "sh_z_1119", location: "경기도 기산동"),
];