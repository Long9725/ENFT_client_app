import 'package:blue/src/model/user.dart';

class Post {
  final List<String> photos;
  final String title;
  final String location;
  final DateTime time;
  final String description;
  final int price;
  final int application;
  final int chatting;
  final int interest;
  final int lookUp;

  Post(
      {required this.photos,
      required this.title,
      required this.location,
      required this.time,
      required this.description,
      required this.price,
      required this.application,
      required this.chatting,
      required this.interest,
      required this.lookUp});
}

List<String> photos = [
  'assets/photos/post1.jpg',
  'assets/photos/post2.jpg',
  'assets/photos/post3.jpg'
];

List postList = [
  Post(
      photos: photos,
      title: "수원시 xx 헬스장 30일 이용권 양도",
      location: userList[0].location,
      time: DateTime.now(),
      description:
          "수원시 xx 헬스장 30일 이용권 양도합니다. 수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다수원시 xx 헬스장 30일 이용권 양도합니다",
      price: 400000,
      application: 0,
      chatting: 0,
      interest: 0,
      lookUp: 0)
];
