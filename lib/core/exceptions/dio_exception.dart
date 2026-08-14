// lib/core/utils/exceptions/dio_exception.dart
import 'package:dio/dio.dart';

class TDioException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  TDioException({required this.message, this.statusCode, this.errorCode});

  factory TDioException.fromDioException(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final errorCode = dioException.response?.data['error'];

    return TDioException(
      message: dioException.message ?? 'An error occurred',
      statusCode: statusCode,
      errorCode: errorCode,
    );
  }

  @override
  String toString() {
    return 'TDioException{message: $message, statusCode: $statusCode, errorCode: $errorCode}';
  }
}
