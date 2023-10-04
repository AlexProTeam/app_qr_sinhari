import 'package:dio/dio.dart';

extension DioExt on Dio {
  /// Create a new instance of dio with custom interceptors / use
  Dio copyWith({
    List<Interceptor>? interceptors,
    BaseOptions? options,
  }) =>
      Dio(options ?? this.options)
        ..interceptors.addAll(interceptors ?? this.interceptors);
}
