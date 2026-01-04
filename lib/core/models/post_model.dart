class PostModel {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final int likes;
  final int dislikes;
  final int views;
  final int userId;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: (json['tags'] as List?)?.cast<String>() ?? [],
      likes: json['reactions']?['likes'] ?? 0,
      dislikes: json['reactions']?['dislikes'] ?? 0,
      views: json['views'] ?? 0,
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': {
        'likes': likes,
        'dislikes': dislikes,
      },
      'views': views,
      'userId': userId,
    };
  }
}

