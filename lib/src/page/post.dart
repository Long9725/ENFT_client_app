import 'package:blue/src/helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:blue/src/model/user.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<String> photos = [
    'assets/photos/post1.jpg',
    'assets/photos/post2.jpg',
    'assets/photos/post3.jpg'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 300,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    photos[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: photos.length,
                pagination: const SwiperPagination(),
              )),
          Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(userList[0].profile))),
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userList[0].nickName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Text(
                            userList[0].location,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    height: kDefaultPadding * 2,
                    thickness: 1,
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
