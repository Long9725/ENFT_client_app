import 'package:blue/src/helper.dart';
import 'package:flutter/material.dart';

class LoadingHud {
  BuildContext context;

  LoadingHud(this.context);

  void showHud() {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                  strokeWidth: 6,
                  backgroundColor: Colors.black26,
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor)),
              SizedBox(height: 10),
              Text('Loading',
                  style: TextStyle(color: kPrimaryColor, fontSize: 16))
            ],
          )),
    );
  }

  void hideHud() {
    Navigator.pop(context);
  }
}
