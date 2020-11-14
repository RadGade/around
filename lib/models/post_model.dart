import 'package:flutter/foundation.dart';

class Post {
  String imageUrl;
  String userId;
  Map postion;
  String documentId;

  Post({
    @required this.userId,
    @required this.postion,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'position': postion,
      'url': imageUrl,
    };
  }

  static Post fromMap(
      Map<String, dynamic> map, String documentId, Map position) {
    if (map == null) return null;

    return Post(
      imageUrl: map['url'],
      userId: map['userId'],
      documentId: documentId,
      postion: position,
    );
  }
}
