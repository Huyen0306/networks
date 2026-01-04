import 'package:dio/dio.dart';
import 'package:network/core/network/dio_client.dart';

class CommentService {
  final DioClient _dioClient;

  CommentService() : _dioClient = DioClient();

  // Lấy tất cả comments theo post ID
  Future<Response> getCommentsByPostId(int postId) async {
    return await _dioClient.dio.get('/comments/post/$postId');
  }

  // Lấy tất cả comments (optional)
  Future<Response> getComments({
    int? limit,
    int? skip,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;

    return await _dioClient.dio.get(
      '/comments',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }
}

