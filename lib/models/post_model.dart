import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String imageUrl;
  final String userId;
  final Map postion;
  final String documentId;

  Post({
    @required this.userId,
    @required this.title,
    @required this.postion,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'position': postion,
      'imageUrl': imageUrl,
    };
  }

  static Post fromMap(
      Map<String, dynamic> map, String documentId, Map position) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      documentId: documentId,
      postion: position,
    );
  }
}
