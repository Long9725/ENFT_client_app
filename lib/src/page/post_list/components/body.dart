import 'package:flutter/material.dart';

import 'package:blue/src/model/Post.dart';
import 'package:blue/src/model/User.dart';

import 'package:blue/src/page/post/post.dart';

import 'package:blue/src/page/post_list/components/list_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(10)),
          ),
          title: '맥북 프로 터치바 13인치 16년 판매합니다',
          position: '화성시 기산동',
          readDuration: '5분 전',
          price: '600,000원',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage(post: postList[0], user: userList[0])));
          },
        ),
        CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
          title: '맥북 에어 m1을 아이패드 프로 12.9 4세대+스마트 키보드와 교환 원합니다',
          position: '수원시 권선동',
          readDuration: '2일 전',
          price: '',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage(post: postList[0], user: userList[1])));
          },
        ),
        CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
          title: '맥북 에어 m1을 아이패드 프로 12.9 4세대+스마트 키보드와 교환 원합니다. 흥정 가능',
          position: '수원시 권선동',
          readDuration: '2일 전',
          price: '',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage(post: postList[0], user: userList[2])));
          },
        ),
        CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
          title: '맥북 에어 m1을 아이패드 프로 12.9 4세대+스마트 키보드와 교환 원합니다',
          position: '수원시 권선동',
          readDuration: '2일 전',
          price: '',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage(post: postList[0], user: userList[3])));
          },
        ),
        CustomListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
          title: '맥북 에어 m1을 아이패드 프로 12.9 4세대+스마트 키보드와 교환 원합니다',
          position: '수원시 권선동',
          readDuration: '2일 전',
          price: '',
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage(post: postList[0], user: userList[0])));
          },
        ),
      ],
    );
  }
}