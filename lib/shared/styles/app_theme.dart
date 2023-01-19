import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: AppColors.myColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Tajawal',
    colorScheme: const ColorScheme(
      background: AppColors.primaryColor,
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.myWhite,
      secondary: AppColors.primaryColor,
      onSecondary: Colors.white,
      error: AppColors.errorColor,
      onError: AppColors.errorColor,
      onBackground: Colors.grey,
      surface: AppColors.myWhite,
      onSurface: AppColors.myGery,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.black,
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 68.h,
      iconTheme: const IconThemeData(
        color: AppColors.myWhite,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.myGerySecond,
      elevation: 20.0,
    ),
    textTheme: TextTheme(
      button: TextStyle(fontSize: 18.sp),
      headline4: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
