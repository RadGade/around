import 'dart:io';

import 'package:compound/locator.dart';
import 'package:compound/models/post_model.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class PostViewModel extends BaseModel {
  final GeoFirestoreService _firestoreService = locator<GeoFirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;
}


