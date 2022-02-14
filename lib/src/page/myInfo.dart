import 'package:blue/src/helper.dart';
import 'package:flutter/material.dart';

import 'package:blue/src/model/User.dart';

class MyInfoPage extends StatelessWidget {
  final User user;
  static const historyIcons = [
    "assets/icons/receipt.png",
    "assets/icons/shopping-bag.png",
    "assets/icons/heart.png"
  ];
  static const historyTitles = ["판매내역", "구매내역", "관심목록"];
  static const infoTileIcons = [
    Icons.location_on_outlined,
    Icons.my_location_rounded,
    Icons.credit_card_rounded,
    Icons.category_rounded,
    Icons.border_color_rounded,
    Icons.campaign_rounded,
    Icons.email_outlined,
    Icons.notifications_none_rounded,
    Icons.headset_mic_rounded,
    Icons.settings
  ];
  static const infoTileTexts = [
    "내 동네 설정",
    "동네 인증하기",
    "결제정보",
    "관심 카테고리 설정",
    "헬스장 글/댓글",
    "지역광고",
    "친구초대",
    "공지사항",
    "자주 묻는 질문",
    "설정"
  ];

  const MyInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: kDefaultPadding,
          title: const Text(
            "내 정보",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.black))
          ],
          elevation: 0,
        ),
        backgroundColor: Colors.grey.withOpacity(0.25),
        body: SingleChildScrollView(
            child: Column(
          children: [
            buildUserProfileBox(),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            for (int i = 0; i < 4; i++)
              buildIconTextTile(infoTileIcons[i], infoTileTexts[i]),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            for (int i = 4; i < 6; i++)
              buildIconTextTile(infoTileIcons[i], infoTileTexts[i]),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            for (int i = 6; i < infoTileIcons.length; i++)
              buildIconTextTile(infoTileIcons[i], infoTileTexts[i]),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
          ],
        )));
  }

  Widget buildUserProfileBox() {
    return PhysicalModel(
        color: Colors.white,
        elevation: 1,
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    image: DecorationImage(
                                        image: AssetImage(user.profile),
                                        fit: BoxFit.contain))),
                            Positioned(
                                top: 35,
                                left: 35,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                ))
                          ],
                        )),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(user.nickName,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                          height: kDefaultPadding / 4),
                                      Text(user.location,
                                          style: TextStyle(
                                              color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            ))),
                  ],
                ),
                const SizedBox(height: kDefaultPadding * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < historyIcons.length; i++)
                      buildHistoryButton(historyIcons[i], historyTitles[i])
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
              ],
            )));
  }

  Widget buildHistoryButton(String imageUrl, String title) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                  opacity: 0.9,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff82b6ff)),
                  )),
              Image.asset(imageUrl, height: 30, width: 30, color: kPrimaryColor)
            ],
          ),
          const SizedBox(height: kDefaultPadding / 4),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildIconTextTile(IconData iconData, String text) {
    return PhysicalModel(
        color: Colors.white,
        elevation: 1,
        child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconData, size: 28),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                    child: Text(text, style: const TextStyle(fontSize: 16.0)))
              ],
            )));
  }
}
