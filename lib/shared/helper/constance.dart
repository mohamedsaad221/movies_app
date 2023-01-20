import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../network/local/shared_pref.dart';

String baseUrl = 'https://imdb-api.com/en/API/';
String apiKey = 'k_fgp40s09';
double defaultPadding = 16.0.w;
double defaultRadius = 6.0.r;

bool? isLogin;

Future<bool?> isLoggedIn() async {
  return isLogin = await CacheHelper.getData(key: 'isLogin');
}
