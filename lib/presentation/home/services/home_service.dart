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

  // Tạo bài viết mới
  // Note: dummyjson.com không lưu thực sự, chỉ trả về response giả
  Future<Response> createPost({
    required String title,
    required String body,
    required int userId,
    List<String>? tags,
  }) async {
    return await _dioClient.dio.post(
      '/posts/add',
      data: {
        'title': title,
        'body': body,
        'userId': userId,
        'tags': tags ?? [],
      },
    );
  }
}
