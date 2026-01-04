import 'package:dio/dio.dart';
import 'package:network/core/network/dio_client.dart';

class AuthService {
  final DioClient _dioClient;

  AuthService() : _dioClient = DioClient();

  // Đăng nhập với username và password
  Future<Response> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) async {
    return await _dioClient.dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
        'expiresInMins': expiresInMins,
      },
    );
  }
}

