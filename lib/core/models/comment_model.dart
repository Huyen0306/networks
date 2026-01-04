class CommentModel {
  final int id;
  final String body;
  final int postId;
  final int userId;
  final String? username;

  CommentModel({
    required this.id,
    required this.body,
    required this.postId,
    required this.userId,
    this.username,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      userId: json['user']?['id'] ?? json['userId'] ?? 0,
      username: json['user']?['username'] ?? json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'postId': postId,
      'userId': userId,
      'username': username,
    };
  }
}

