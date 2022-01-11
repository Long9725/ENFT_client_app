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
  Slide(imageUrl: 'assets/lottie/getting-started-coch.json', title: 'This is our Title', descrption: 'L\'option longue phrase pour les troubles de l\'humeur et l\'inquiétude peut être de carences alimentaires sous-jacents appropriés.'),
  Slide(imageUrl: 'assets/lottie/getting-started-lifestyle.json', title: 'Help your lifestyle', descrption: 'L\'option longue phrase pour les troubles de l\'humeur et l\'inquiétude peut être de carences alimentaires sous-jacents appropriés.'),
  Slide(imageUrl: 'assets/lottie/getting-started-treadmill.json', title: 'It\'s just the beginning', descrption: 'L\'option longue phrase pour les troubles de l\'humeur et l\'inquiétude peut être de carences alimentaires sous-jacents appropriés.'),
];