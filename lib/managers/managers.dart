// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_alumunium/common/env/env.dart';
import 'package:mobile_alumunium/exceptions/app_exceptions.dart';
import 'package:mobile_alumunium/managers/dio_loging_inceptors.dart';

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
  final SimpleInterceptor _simpleInterceptor;
  final Dio _dio = Dio();

  final String _baseUrl = Env.baseUrl;
  late final Duration _timeout;
  late final Duration _uploadTimeout;

  AppHttpManager(this._simpleInterceptor, this._timeout, this._uploadTimeout) {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(_simpleInterceptor);
    // _timeout = const Duration(seconds: 0);
    // _uploadTimeout = const Duration(seconds: 60);
    ('time out $_timeout');
  }

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
      // Handle nested data structure
      if (response.data is Map && response.data.containsKey('data')) {
        response.data = response.data['data']; // Extract the inner data
      }

      return response;
    }
    throw _parseError(response);
  }

  Exception _parseError(Response response) {
    String message = 'Unknown error';
    dynamic responseData = response.data;

    try {
      // Coba parsing berbagai format response
      if (responseData is Map) {
        message = responseData['message']?.toString() ??
            responseData['error']?.toString() ??
            'Unknown server error';
      } else if (responseData is String) {
        // Coba parse JSON string
        try {
          final parsed = json.decode(responseData);
          if (parsed is Map) {
            message = parsed['message']?.toString() ??
                parsed['error']?.toString() ??
                _removeHtmlTags(responseData);
          } else {
            message = _removeHtmlTags(responseData);
          }
        } catch (_) {
          message = _removeHtmlTags(responseData);
        }
      }
    } catch (e) {
      print('Error parsing error message: $e');
      message = 'Unknown error (failed to parse)';
    }

    // Log pesan error yang ditemukan
    print('Extracted error message: $message');

    // Handle pesan error spesifik
    if (message.toUpperCase().contains('EMAIL') ||
        message.toUpperCase().contains('PASSWORD')) {
      return InvalidCredentialException(message);
    }

    switch (response.statusCode) {
      case 400:
        return BadRequestException(message);
      case 401:
        return UnauthorisedException(message);
      case 403:
        return UnauthorisedException(message);
      case 404:
        return NotFoundException(message);
      case 422:
        return UnauthorisedException(message);
      case 406:
        return NotAcceptableException(message);
      case 500:
      default:
        return FetchDataException(message);
    }
  }

  Future<Exception> _handleError(dynamic error) async {
    if (error is DioException) {
      // Tambahkan logging untuk debugging
      print('DioError: ${error.type}');
      print('DioError Message: ${error.message}');

      if (error.response != null) {
        return _parseError(error.response!);
      }

      // Handle berbagai tipe DioError
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException();
        case DioExceptionType.badCertificate:
          return FetchDataException("Sertifikat SSL tidak valid");
        case DioExceptionType.badResponse:
          return FetchDataException("Response tidak valid dari server");
        case DioExceptionType.cancel:
          return FetchDataException("Request dibatalkan");
        case DioExceptionType.connectionError:
          return NetworkException();
        case DioExceptionType.unknown:
          return FetchDataException(error.message ?? "Unknown network error");
      }
    }

    // Jika error bukan DioException
    print('Non-Dio Error: $error');
    return FetchDataException("Terjadi kesalahan: ${error.toString()}");
  }

  String _removeHtmlTags(String htmlText) {
    final exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
