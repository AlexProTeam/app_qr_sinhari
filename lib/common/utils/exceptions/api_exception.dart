import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiException {
  final bool success;
  final String data;
  final Object exception;
  final DioError? networkError;

  ApiException._({
    required this.exception,
    this.success = false,
    this.data = '',
  }) : networkError = exception is DioError ? exception : null;

  String get displayError => toBeginningOfSentenceCase(data) ?? '';

  factory ApiException.customError({
    bool? errorCode,
    String? errorMessage,
  }) =>
      ApiException._(
        exception: Object(),
        success: errorCode ?? false,
        data: errorMessage ?? '',
      );

  factory ApiException.error(
    Object error, [
    StackTrace? stackTrace,
  ]) {
    if (error is DioError) return ApiException(exception: error);
    log("Error not from Dio: ${stackTrace.toString()}");

    return ApiException._(
      exception: error,
      success: false,
      data: error.toString(),
    );
  }

  factory ApiException({required DioError exception}) {
    switch (exception.type) {
      case DioErrorType.badResponse:
        return _handleErrorWithResponse(exception);
      case DioErrorType.cancel:
        return ApiException._(
          exception: exception,
          data: 'Cancelled',
        );
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return ApiException._(
          exception: exception,
          data: _timeOutMessages[exception.type]!,
        );
      default:
        if (exception.error is SocketException ||
            exception.error is HttpException) {
          return ApiException._(
            exception: exception,
            data: 'kết nối có vấn đề',
          );
        }
        if (exception.error != null) {
          return ApiException._(
            exception: exception,
            data: exception.error.toString(),
          );
        }
    }

    return ApiException._(exception: exception);
  }
}

/// Checking for 'error' and 'message' type of List is something that is
/// already done previously. Not sure where does it impact on the whole
/// application but we'll keep it for now.
ApiException _handleErrorWithResponse(DioError exception) {
  try {
    final errorBody = exception.response!.data;

    if (errorBody is Map && errorBody['message'] is List) {
      final message = errorBody['message'] as List;
      final errorMessages = message
          .map((e) => toBeginningOfSentenceCase(e.toString()))
          .join("\n");

      return ApiException._(
        exception: exception,
        data: errorMessages,
        success: errorBody['statusCode'],
      );
    }

    final message = errorBody['message'] ?? "N/A";

    return ApiException._(
      exception: exception,
      data: message,
      success:
          errorBody['statusCode'] ?? exception.response!.statusCode.toString(),
    );
  } catch (e) {
    // try to get Dio internal error which might due to service not available
    if (exception.response!.statusMessage != null &&
        exception.response!.statusMessage!.isNotEmpty) {
      return ApiException._(
        exception: exception,
        data: exception.response!.statusMessage.toString(),
        success: false,
      );
    }

    return ApiException._(
      exception: exception,
      data: e.toString(),
    );
  }
}

final _timeOutMessages = {
  DioErrorType.connectionTimeout: 'Timeout',
  DioErrorType.receiveTimeout: 'Receive Timeout',
  DioErrorType.sendTimeout: 'Send Timeout',
};
