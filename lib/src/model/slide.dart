import 'package:flutter/cupertino.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String descrption;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.descrption,
  });
}

final slideList = [
  Slide(imageUrl: 'assets/lottie/getting-started-coch.json', title: '안전한 헬스장', descrption: '헬스장의 안전을 위해서,\n고유한 QR코드로 헬스장 무단이용을 방지합니다'),
  Slide(imageUrl: 'assets/lottie/getting-started-lifestyle.json', title: '온라인 이용권 양도', descrption: '헬스장에서 서류를 작성하지 않아도 됩니다.\n주변 동네 사람과 헬스장 이용권을 양도해보세요!'),
  Slide(imageUrl: 'assets/lottie/getting-started-treadmill.json', title: '시작해보세요!', descrption: '여러분의 소중한 운동을 위해서 안전하고 편리한 헬스장 이용에 최선을 다하겠습니다.'),
];