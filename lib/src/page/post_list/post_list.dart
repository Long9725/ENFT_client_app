import 'package:flutter/material.dart';

import 'package:blue/src/page/post_list/components/body.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [],
      ),
      automaticallyImplyLeading: false,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0.2,
    );
  }
}
