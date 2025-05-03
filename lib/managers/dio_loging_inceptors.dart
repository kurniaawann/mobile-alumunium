import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SimpleInterceptor extends Interceptor {
  final String? token;

  SimpleInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Tambahkan Authorization header jika ada token
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    // Log request
    debugPrint('[DIO] Request: ${options.method} ${options.uri}');
    debugPrint('[DIO] Headers: ${options.headers}');
    debugPrint('[DIO] Data: ${options.data}');

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
