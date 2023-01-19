import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'control_state.dart';

class ControlCubit extends Cubit<ControlState> {
  ControlCubit() : super(ControlInitial());

  static ControlCubit get(context) => BlocProvider.of(context);

  // Locale? localeApp = Locale(lang ?? 'en');
  //
  // void changeLocaleApp(String languageCode) async {
  //   if (localeApp!.countryCode != languageCode) {
  //     lang = languageCode;
  //     localeApp = Locale(languageCode);
  //     await CacheHelper.saveData(key: 'lang', value: languageCode);
  //     emit(ChangeLanguageState());
  //   }
  // }

  // void clearLocale() {
  //   localeApp = null;
  //   emit(ClearLanguageState());
  // }

  final Connectivity _connectivity = Connectivity();

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  Future<void> startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (result == ConnectivityResult.none) {
          _isOnline = false;
          emit(ControlConnectionFailed());
        } else {
          await _updateConnectionStatus().then(
            (bool isConnected) {
              _isOnline = isConnected;
              emit(ControlConnectionSuccess());
            },
          );
        }
      },
    );
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        _isOnline = false;
        emit(ControlConnectionFailed());
      } else {
        _isOnline = true;
        emit(ControlConnectionSuccess());
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException: " + e.toString());
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      //return false;
    }
    return isConnected;
  }
}
