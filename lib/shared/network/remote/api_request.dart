import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helper/constance.dart';

class ApiRequest {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 5000
          // followRedirects: false,
          // validateStatus: (status) {
          //   return status! < 500;
          // },
          ),
    );
    debugPrint(dio.runtimeType.toString());
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    log('path: $path$query');
    return await dio!.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String path,
      dynamic data,
      String? token,
      String? deviceToken}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
      'device-token': deviceToken
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  static Future<Response> postMultiPartData({
    required String path,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
    Function(int, int)? onSendProgress,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': token,
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  static Future<Response> postDataWithPhoto({
    required String path,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
    Function(int, int)? onSendProgress,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': token,
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.put(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> patchData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.patch(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.delete(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
