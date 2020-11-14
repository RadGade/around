import 'dart:io';

import 'package:compound/locator.dart';
import 'package:compound/models/post_model.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends BaseModel {
  final GeoFirestoreService _firestoreService = locator<GeoFirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Post _edittingPost;

  bool get _editting => _edittingPost != null;

  Future getImage(path_img) async {
    var tempImage = path_img;
    if (tempImage != null) {
      _selectedImage = File(tempImage);
      notifyListeners();
    }
  }

  Future addPost() async {
    setBusy(true);

    CloudStorageResult storageResult;
    storageResult = await _cloudStorageService.uploadImage(
      imageToUpload: _selectedImage,
    );

    await _firestoreService.addPost(Post(
      imageUrl: storageResult.imageUrl,
    ));

    setBusy(false);

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
