// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_alumunium/common/env/env.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';

abstract class HttpManager {
  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Response> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Response> put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });
}

class AppHttpManager implements HttpManager {
  // final LoggingInterceptor _loggingInterceptor;
  final Dio _dio = Dio();

  final String _baseUrl = Env.baseUrl;
  late final Duration _timeout;
  late final Duration _uploadTimeout;

  // AppHttpManager()
  //     : _loggingInterceptor = LoggingInterceptor(
  //         authLocal: serviceLocator(),
  //         onUnauthorized: () {
  //           final authBloc = serviceLocator<AuthBloc>();
  //           authBloc.add(const LoggedOut(runPost: false));
  //         },
  //       ) {
  //   _timeout = Duration(seconds: Env().configHttpTimeout!);
  //   _uploadTimeout = Duration(seconds: Env().configHttpUploadTimeout!);

  //   _dio.options.baseUrl = _baseUrl;
  //   _dio.interceptors.add(_loggingInterceptor);
  // }

  @override
  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'GET',
      url: url,
      data: data,
      query: query,
      headers: headers,
    );
  }

  @override
  Future<Response> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) {
    return _request(
      method: 'POST',
      url: url,
      data: data,
      query: query,
      headers: headers,
      formData: formData,
      isUploadImage: isUploadImage,
    );
  }

  @override
  Future<Response> patch({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'PATCH',
      url: url,
      data: data,
      query: query,
      headers: headers,
    );
  }

  @override
  Future<Response> put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) {
    return _request(
      method: 'PUT',
      url: url,
      data: data,
      query: query,
      headers: headers,
      formData: formData,
      isUploadImage: isUploadImage,
    );
  }

  @override
  Future<Response> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'DELETE',
      url: url,
      data: data,
      query: query,
      headers: headers,
    );
  }

  Future<Response> _request({
    required String method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      final response = await _dio
          .request(
        _buildUrl(url, query),
        data: formData ?? (data != null ? json.encode(data) : null),
        options: Options(
          method: method,
          headers: _buildHeaders(headers),
        ),
      )
          .timeout(isUploadImage ? _uploadTimeout : _timeout, onTimeout: () {
        throw NetworkException();
      });

      return _handleResponse(response);
    } catch (error) {
      throw await _handleError(error);
    }
  }

  String _buildUrl(String path, Map<String, dynamic>? query) {
    final uri = Uri.parse(_baseUrl + path).replace(queryParameters: query);
    if (kDebugMode) {
      print('Request URL: $uri');
    }

    return uri.toString();
  }

  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      if (customHeaders != null) ...customHeaders,
    };
  }

  Response _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response;
    }
    throw _parseError(response);
  }

  Exception _parseError(Response response) {
    String message = '';
    try {
      message = response.data['message'] ?? '';
    } catch (_) {
      if (response.data is String) {
        message = _removeHtmlTags(response.data);
      }
    }

    if (message.toUpperCase() == 'INVALID CREDENTIALS' ||
        message.toUpperCase() == 'MISSING AUTHENTICATION') {
      throw InvalidCredentialException("Sesi telah habis, harap login kembali");
    }

    switch (response.statusCode) {
      case 400:
        return BadRequestException(
            message.isNotEmpty ? message : "Bad request");
      case 401:
      case 403:
        return UnauthorisedException(
            message.isNotEmpty ? message : "Invalid token");
      case 404:
        return NotFoundException(message.isNotEmpty ? message : "Not found");
      case 422:
        return UnauthorisedException(
            message.isNotEmpty ? message : "Invalid credentials");
      case 406:
        return NotAcceptableException(
            message.isNotEmpty ? message : "Not Acceptable");
      case 500:
      default:
        return FetchDataException(
            message.isNotEmpty ? message : "Unknown Error");
    }
  }

  Future<Exception> _handleError(dynamic error) async {
    if (error is DioException) {
      final response = error.response;
      if (response != null) {
        return _parseError(response);
      }
    }
    return FetchDataException("Unknown Error");
  }

  String _removeHtmlTags(String htmlText) {
    final exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
