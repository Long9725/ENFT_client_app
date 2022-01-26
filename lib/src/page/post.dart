import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:blue/src/helper.dart';
import 'package:blue/src/model/post.dart';
import 'package:blue/src/model/user.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.post, required this.user}) : super(key: key);

  final Post post;
  final User user;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late String countText;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countText = "";
    if (widget.post.application != 0) {
      countText += "신청 " + postList[0].application.toString();
    }
    if (widget.post.chatting != 0) {
      if (countText.isEmpty) {
        countText += "채팅 " + postList[0].chatting.toString();
      } else {
        countText += " ꞏ " + "채팅 " + postList[0].chatting.toString();
      }
    }
    if (widget.post.interest != 0) {
      if (countText.isEmpty) {
        countText += "관심 " + postList[0].interest.toString();
      } else {
        countText += " ꞏ " + "관심 " + postList[0].interest.toString();
      }
    }
    if (widget.post.lookUp != 0) {
      if (countText.isEmpty) {
        countText += "관심 " + postList[0].lookUp.toString();
      } else {
        countText += " ꞏ " + "관심 " + postList[0].lookUp.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(Icons.favorite_border_rounded)),
                    const SizedBox(width: kDefaultPadding / 2),
                    const SizedBox(
                        height: 40,
                        child: VerticalDivider(
                          thickness: 1,
                        )),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                        child: Text(currencyFormat(postList[0].price),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text(
                        "채팅으로 거래하기",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              )
            ])),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        widget.post.photos[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: photos.length,
                    pagination: const SwiperPagination(),
                  )),
              // SizedBox(height: kDefaultPadding,),
              Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      image: AssetImage(widget.user.profile))),
                            ),
                          ),
                          const SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.nickName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding / 4,
                              ),
                              Text(
                                widget.user.location,
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        height: kDefaultPadding * 3,
                        thickness: 1,
                      ),
                      Text(widget.post.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        distanceTimeFromNow(widget.post.time),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        widget.post.description,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        children: [
                          Text(
                            countText,
                            style: TextStyle(color: Colors.grey.shade600),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
