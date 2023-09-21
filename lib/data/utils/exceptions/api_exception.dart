import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiException {
  final int status;
  final String message;
  final Object exception;
  final DioException? networkError;

  ApiException._({
    required this.exception,
    this.status = 0,
    this.message = '',
  }) : networkError = exception is DioException ? exception : null;

  String get displayError => toBeginningOfSentenceCase(message) ?? '';

  factory ApiException.customError({
    int? errorCode,
    String? errorMessage,
  }) =>
      ApiException._(
        exception: Object(),
        status: errorCode ?? 404,
        message: errorMessage ?? '',
      );

  factory ApiException.error(
    Object error, [
    StackTrace? stackTrace,
  ]) {
    if (error is DioException) return ApiException(exception: error);
    log("Error not from Dio: ${stackTrace.toString()}");

    return ApiException._(
      exception: error,
      status: 0,
      message: error.toString(),
    );
  }

  factory ApiException({required DioException exception}) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return _handleErrorWithResponse(exception);
      case DioExceptionType.cancel:
        return ApiException._(
          exception: exception,
          message: 'Cancelled',
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException._(
          exception: exception,
          message: _timeOutMessages[exception.type]!,
        );
      default:
        if (exception.error is SocketException ||
            exception.error is HttpException) {
          return ApiException._(
            exception: exception,
            message: 'Connection Problem',
          );
        }
        if (exception.error != null) {
          return ApiException._(
            exception: exception,
            message: exception.error.toString(),
          );
        }
    }

    return ApiException._(exception: exception);
  }
}

/// Checking for 'error' and 'message' type of List is something that is
/// already done previously. Not sure where does it impact on the whole
/// application but we'll keep it for now.
ApiException _handleErrorWithResponse(DioException exception) {
  try {
    final errorBody = exception.response!.data;

    if (errorBody is Map && errorBody['message'] is List) {
      final message = errorBody['message'] as List;
      final errorMessages = message
          .map((e) => toBeginningOfSentenceCase(e.toString()))
          .join("\n");

      return ApiException._(
        exception: exception,
        message: errorMessages,
        status: errorBody['statusCode'],
      );
    }

    final message = errorBody['message'] ?? "N/A";

    return ApiException._(
      exception: exception,
      message: message,
      status:
          errorBody['statusCode'] ?? exception.response!.statusCode.toString(),
    );
  } catch (e) {
    // try to get Dio internal error which might due to service not available
    if (exception.response!.statusMessage != null &&
        exception.response!.statusMessage!.isNotEmpty) {
      return ApiException._(
        exception: exception,
        message: exception.response!.statusMessage.toString(),
        status: exception.response?.statusCode ?? 0,
      );
    }

    return ApiException._(
      exception: exception,
      message: e.toString(),
    );
  }
}

final _timeOutMessages = {
  DioExceptionType.connectionTimeout: 'Connect Timeout',
  DioExceptionType.receiveTimeout: 'Receive Timeout',
  DioExceptionType.sendTimeout: 'Send Timeout',
};
