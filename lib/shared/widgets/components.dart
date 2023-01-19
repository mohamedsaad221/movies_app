import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/login_view/login_screen.dart';
import '../network/local/shared_pref.dart';
import '../styles/app_colors.dart';

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

void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    // FirebaseAuth.instance.currentUser!.delete().then((value) {
    // FirebaseAuth.instance.signOut();
    // });

    navigateAndFinish(context, LoginScreen());
  });

  Widget myDivider() => Container(
        width: double.infinity,
        height: 1.h,
        color: AppColors.myGery,
      );
}
