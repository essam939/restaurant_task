import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant/authentication/core/error/exceptions.dart';
import 'package:restaurant/authentication/core/error/failure.dart';

import 'dio_consumer.dart';
import 'error_message_remote.dart';

class ApiConsumer extends DioConsumer {
  factory ApiConsumer() => _instance;
  static final ApiConsumer _instance = ApiConsumer._internal();

  ApiConsumer._internal() {
    dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (Object? object) => log(object.toString(), name: 'HTTP'),
      ),
    );
  }

  late final Dio dio;


  @override
  Future<Either<Failure, dynamic>> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? data,
        FormData? formData,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _instance.dio.get(
        uri,
        data: data ?? formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (exception) {
      return Left(
        ServerFailure(
          _handleError(exception),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? data,
        FormData? formData,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _instance.dio.post(
        uri,
        queryParameters: queryParameters,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      return Right(response.data);
    } on DioException catch (exception) {
      return Left(
        ServerFailure(
          _handleError(exception),
        ),
      );
    }
  }
  ErrorMessageModel _handleError(DioException exception) {
    return ErrorMessageModel(
      en: exception.response?.data['localizedMessage']['en'] as String,
      ar: exception.response?.data['localizedMessage']['ar'] as String,
    );
  }
}
