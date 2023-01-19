import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/font_styles.dart';
import '../../shared/widgets/custom_text.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 250.r,
            ),
            CustomText(
              text: 'no_internet_connection',
              textStyle: largeTitleTextStyle(),
              softWrap: true,
              maxLine: 1,
            ),
            CustomText(
              text: 'no_internet_connection_description',
              textStyle: primaryTextStyle().copyWith(fontSize: 20.sp),
              softWrap: true,
              maxLine: 5,
            ),
          ],
        ),
      ),
    );
  }
}
