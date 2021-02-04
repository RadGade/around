
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();
var url;
FirebaseStorage storage = FirebaseStorage.instance;
    final firebaseStorageRef =
        storage.ref().child(imageFileName);

    UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

     uploadTask.whenComplete(() => {
        url = firebaseStorageRef.getDownloadURL()
    });
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
  }

  // Future deleteImage(String imageFileName) async {
  //   final StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(imageFileName);

  //   try {
  //     await firebaseStorageRef.delete();
  //     return true;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}