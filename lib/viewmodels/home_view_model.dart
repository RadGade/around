import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/models/post_model.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final GeoFirestoreService _geofirestoreService =
      locator<GeoFirestoreService>();
  final CloudStorageService _cloudstorageService =
      locator<CloudStorageService>();

  List _posts = [];
  List get posts => _posts;

  void listenToPosts() async {
    setBusy(true);
    var postsResults = await _geofirestoreService.getPostsOnceOff();
    setBusy(false);
    await postsResults.listen((List<DocumentSnapshot> documentList) {
      documentList.forEach((DocumentSnapshot doc) {
        String posturl = doc.data['url'];
        _posts.add(posturl);
        notifyListeners();
        print(_posts);
      });
    });
  }
}

//give users new stuff when they refresh even if
//its outside the bubble zone of the users

//notify user when ever there is a small change
//keep the user in the app
//dont force the user to sign up first
// show them the feed first

//if the user has nothing to see then get outside the bubble
//
