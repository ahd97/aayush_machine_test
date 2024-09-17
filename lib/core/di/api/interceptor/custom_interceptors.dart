import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aayush_machine_test/core/db/app_db.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {


    if (appDB.token.isNotEmpty)
      options.headers['token'] = appDB.token;
    else
      options.headers['token'] = "";

    debugPrint("Headers: ${jsonEncode(options.headers)}");

    return handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.realUri}');
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return handler.next(err);
  }
}
