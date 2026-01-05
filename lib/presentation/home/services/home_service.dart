import 'package:dio/dio.dart';
import 'package:network/core/network/dio_client.dart';

class HomeService {
  final DioClient _dioClient;

  HomeService() : _dioClient = DioClient();

  // Lấy danh sách tất cả posts
  Future<Response> getPosts() async {
    return await _dioClient.dio.get('/posts');
  }

  // Lấy một post cụ thể theo ID
  Future<Response> getPost(int id) async {
    return await _dioClient.dio.get('/posts/$id');
  }

  // Tìm kiếm bài viết
  Future<Response> searchPosts(String query) async {
    return await _dioClient.dio.get(
      '/posts/search',
      queryParameters: {'q': query},
    );
  }
}
