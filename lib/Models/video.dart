// lib/models/video.dart
import 'dart:convert';

class Video {
  final String id;
  final String title;
  final String description;
  final String url;
  final String thumbnail;
  final String category;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.thumbnail,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'thumbnail': thumbnail,
      'category': category,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      category: map['category'] ?? 'Uncategorized',
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));
}
