import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../network/local/shared_pref.dart';

String tableUser = 'user';
String tableMovies = 'movie';

String baseUrl = 'https://imdb-api.com/en/API/';
String apiKey = 'k_fgp40s09';
double defaultPadding = 16.0.w;
double defaultRadius = 6.0.r;
double defaultFontSize = 18.sp;

bool? isLogin;
bool? isWelcomeBool;

Future<bool?> isLoggedIn() async {
  return isLogin = await CacheHelper.getData(key: 'isLogin');
}

Future<bool?> isWelcome() async {
  return isWelcomeBool = await CacheHelper.getData(key: 'isWelcome');
}
