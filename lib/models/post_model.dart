import 'package:flutter/foundation.dart';

class Post {
  String title;
  String imageUrl;
  String userId;
  Map postion;
  String documentId;

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
