import 'package:dio/dio.dart';
import 'package:network/core/network/dio_client.dart';

class FriendsService {
  final DioClient _dioClient;

  FriendsService() : _dioClient = DioClient();

  // Lấy danh sách tất cả users
  Future<Response> getUsers() async {
    return await _dioClient.dio.get('/users');
  }

  // Lấy một user cụ thể theo ID
  Future<Response> getUser(int id) async {
    return await _dioClient.dio.get('/users/$id');
  }
}
