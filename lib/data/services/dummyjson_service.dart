import 'package:dio/dio.dart';
import 'package:network/core/network/dio_client.dart';

class DummyJsonService {
  final DioClient _dioClient;

  DummyJsonService({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<Response> getProducts({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/products',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getProduct(int id) async {
    return await _dioClient.dio.get('/products/$id');
  }

  Future<Response> getUsers({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/users',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getUser(int id) async {
    return await _dioClient.dio.get('/users/$id');
  }

  Future<Response> getPosts({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/posts',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getPost(int id) async {
    return await _dioClient.dio.get('/posts/$id');
  }

  Future<Response> getCarts({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/carts',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getCart(int id) async {
    return await _dioClient.dio.get('/carts/$id');
  }

  Future<Response> getTodos({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/todos',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getTodo(int id) async {
    return await _dioClient.dio.get('/todos/$id');
  }

  Future<Response> getQuotes({
    int? limit,
    int? skip,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;

    return await _dioClient.dio.get(
      '/quotes',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getQuote(int id) async {
    return await _dioClient.dio.get('/quotes/$id');
  }

  Future<Response> getComments({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/comments',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getComment(int id) async {
    return await _dioClient.dio.get('/comments/$id');
  }

  Future<Response> getRecipes({
    int? limit,
    int? skip,
    String? select,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (skip != null) queryParams['skip'] = skip;
    if (select != null) queryParams['select'] = select;

    return await _dioClient.dio.get(
      '/recipes',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
  }

  Future<Response> getRecipe(int id) async {
    return await _dioClient.dio.get('/recipes/$id');
  }

  Future<Response> searchProducts(String query) async {
    return await _dioClient.dio.get(
      '/products/search',
      queryParameters: {'q': query},
    );
  }

  Future<Response> login(String username, String password) async {
    return await _dioClient.dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );
  }
}

