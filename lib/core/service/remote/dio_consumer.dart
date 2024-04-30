import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant/core/error/failure.dart';

abstract class DioConsumer {
  Future<Either<Failure, dynamic>> get(String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Either<Failure, dynamic>> post(String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}


