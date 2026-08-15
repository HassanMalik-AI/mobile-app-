import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
//import 'package:fitai_coach/core/utils/exceptions/dio_exception.dart';

class DioClient {
  DioClient._() {
    _dio = Dio(
      BaseOptions(
        // Use localhost for web (not 10.0.2.2)
        baseUrl: 'http://127.0.0.1:8000',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
        // ✅ IMPORTANT FOR WEB
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            try {
              final token = await user.getIdToken();
              options.headers['Authorization'] = 'Bearer $token';
              log('✅ Token attached to request');
            } catch (e) {
              log('❌ Token error: $e');
            }
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              try {
                final freshToken = await user.getIdToken(true);
                final options = error.requestOptions;
                options.headers['Authorization'] = 'Bearer $freshToken';
                final response = await _dio.fetch(options);
                return handler.resolve(response);
              } catch (e) {
                log('❌ Refresh failed: $e');
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  late final Dio _dio;
  static final DioClient instance = DioClient._();
  Dio get client => _dio;
}
