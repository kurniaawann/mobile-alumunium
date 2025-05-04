import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alumunium/features/presentation/getx/cache_local/cache.dart';
import 'package:mobile_alumunium/managers/helper.dart';

class SimpleInterceptor extends Interceptor {
  final String? token;

  SimpleInterceptor({this.token});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? tokenToUse;

    // Ambil token reset password
    final resetPasswordToken = await TokenStorage.getTokenResetPassword();

    if (resetPasswordToken != null) {
      tokenToUse = resetPasswordToken;
    } else {
      // Kalau nggak ada token reset password, ambil token user
      final userToken = await TokenStorage.getUserToken();
      tokenToUse = userToken;
    }

    printErrorDebug('ini value dari tokennya $tokenToUse');
    if (tokenToUse != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $tokenToUse';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response
    debugPrint(
        '[DIO] Response [${response.statusCode}] ${response.requestOptions.uri}');
    debugPrint('[DIO] Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error
    debugPrint('[DIO] Error: ${err.type} ${err.requestOptions.uri}');
    if (err.response != null) {
      debugPrint('[DIO] Error Data: ${err.response?.data}');
    } else {
      debugPrint('[DIO] Error Message: ${err.message}');
    }
    super.onError(err, handler);
  }
}
