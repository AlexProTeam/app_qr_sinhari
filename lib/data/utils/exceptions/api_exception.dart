import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Project imports:

class ApiException {
  final int errorCode;
  final String errorMessage;
  final Object exception;
  final DioException? networkError;

  ApiException._({
    required this.exception,
    this.errorCode = 0,
    this.errorMessage = '',
  }) : networkError = exception is DioException ? exception : null;

  String get displayError => toBeginningOfSentenceCase(errorMessage) ?? '';

  factory ApiException.customError({
    int? errorCode,
    String? errorMessage,
  }) =>
      ApiException._(
        exception: Object(),
        errorCode: errorCode ?? 404,
        errorMessage: errorMessage ?? '',
      );

  factory ApiException.error(
    Object error, [
    StackTrace? stackTrace,
  ]) {
    if (error is DioException) return ApiException(exception: error);
    log("Error not from Dio: ${stackTrace.toString()}");

    return ApiException._(
      exception: error,
      errorCode: 0,
      errorMessage: error.toString(),
    );
  }

  factory ApiException({required DioException exception}) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return _handleErrorWithResponse(exception);
      case DioExceptionType.cancel:
        return ApiException._(
          exception: exception,
          errorMessage: 'Cancelled',
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException._(
          exception: exception,
          errorMessage: _timeOutMessages[exception.type]!,
        );
      default:
        if (exception.error is SocketException ||
            exception.error is HttpException) {
          return ApiException._(
            exception: exception,
            errorMessage: 'ConnectionProblem',
          );
        }
        if (exception.error != null) {
          return ApiException._(
            exception: exception,
            errorMessage: exception.error.toString(),
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
        errorMessage: errorMessages,
        errorCode: errorBody['statusCode'],
      );
    }

    final message = errorBody['message'] ?? "N/A";

    return ApiException._(
      exception: exception,
      errorMessage: message,
      errorCode:
          errorBody['statusCode'] ?? exception.response!.statusCode.toString(),
    );
  } catch (e) {
    // try to get Dio internal error which might due to service not available
    if (exception.response!.statusMessage != null &&
        exception.response!.statusMessage!.isNotEmpty) {
      return ApiException._(
        exception: exception,
        errorMessage: exception.response!.statusMessage.toString(),
        errorCode: exception.response?.statusCode ?? 0,
      );
    }

    return ApiException._(
      exception: exception,
      errorMessage: e.toString(),
    );
  }
}

final _timeOutMessages = {
  DioExceptionType.connectionTimeout: 'ConnectTimeout',
  DioExceptionType.receiveTimeout: 'ReceiveTimeout',
  DioExceptionType.sendTimeout: 'SendTimeout',
};
