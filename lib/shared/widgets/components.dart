import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void showToast({
  required String text,
  required ShowToastColor stateColor,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(stateColor),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ShowToastColor { SUCCESS, ERROR, WARING }

Color chooseToastColor(ShowToastColor state) {
  Color color;

  switch (state) {
    case ShowToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ShowToastColor.ERROR:
      color = Colors.red;
      break;
    case ShowToastColor.WARING:
      color = Colors.amberAccent;
      break;
  }
  return color;
}
