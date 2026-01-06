import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network/core/models/post_model.dart';

/// Provider quản lý các bài viết do người dùng tạo (lưu vào bộ nhớ tạm)
/// Vì dummyjson.com không lưu posts thực sự, nên ta lưu local
class PostProvider extends ChangeNotifier {
  static const _userPostsKey = 'user_posts';

  // Danh sách posts do người dùng tạo
  List<PostModel> _userPosts = [];

  List<PostModel> get userPosts => _userPosts;

  PostProvider() {
    _loadUserPosts();
  }

  /// Load posts đã lưu từ SharedPreferences
  Future<void> _loadUserPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = prefs.getStringList(_userPostsKey);

    if (postsJson != null) {
      _userPosts = postsJson.map((jsonString) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return PostModel.fromJson(json);
      }).toList();
      notifyListeners();
    }
  }

  /// Lưu posts vào SharedPreferences
  Future<void> _saveUserPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = _userPosts
        .map((post) => jsonEncode(post.toJson()))
        .toList();
    await prefs.setStringList(_userPostsKey, postsJson);
  }

  /// Thêm post mới (sẽ hiển thị đầu danh sách)
  Future<void> addPost(PostModel post) async {
    // Thêm vào đầu danh sách để hiển thị mới nhất trước
    _userPosts.insert(0, post);
    await _saveUserPosts();
    notifyListeners();
  }

  /// Xóa post
  Future<void> removePost(int postId) async {
    _userPosts.removeWhere((post) => post.id == postId);
    await _saveUserPosts();
    notifyListeners();
  }

  /// Xóa tất cả posts của người dùng
  Future<void> clearAllPosts() async {
    _userPosts.clear();
    await _saveUserPosts();
    notifyListeners();
  }

  /// Tạo ID mới cho post (dựa trên timestamp để đảm bảo unique)
  int generateNewPostId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Gộp posts của người dùng với posts từ API
  /// User posts sẽ hiển thị trước
  List<PostModel> mergeWithApiPosts(List<PostModel> apiPosts) {
    // User posts đầu, sau đó là API posts
    return [..._userPosts, ...apiPosts];
  }
}
