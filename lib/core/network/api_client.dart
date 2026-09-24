import 'package:dio/dio.dart';

import 'api_endpoints.dart';

/// Dio client with auth / retry / logging interceptors.
///
/// Unused while `AppConfig.useMockApi` is true; kept future-ready so the
/// mock -> real API swap touches only repository_providers.dart.
/// TODO(Phase 8): enable certificate pinning (documented placeholder) and
/// wire the refresh-token flow.
class ApiClient {
  ApiClient({Dio? dio, String? baseUrl})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
                sendTimeout: const Duration(seconds: 30),
              ),
            ) {
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: false),
    ]);
  }

  final Dio _dio;

  Dio get dio => _dio;
}
