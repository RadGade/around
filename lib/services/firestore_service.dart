import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeoFirestoreService {
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection("posts");
  final Location location = new Location();
  // ignore: close_sinks
  final radius = 100.0;
  final Geoflutterfire geo = Geoflutterfire();
  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    var pos = await location.getLocation();
    var imageList = [];
    var ref = Firestore.instance.collection('posts');
    GeoFirePoint center =
        await geo.point(latitude: pos.latitude, longitude: pos.longitude);

    void DocQuery(List<DocumentSnapshot> documentList) {
      print(documentList);
    }

    try {
      print("sub reacheed");

      Stream<List<DocumentSnapshot>> stream = geo
          .collection(collectionRef: ref)
          .within(center: center, radius: radius, field: 'position');

      return stream;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  // Future listenToPostsRealTime() async {

  //   // Register the handler for when the posts data changes
  //   _postsCollectionReference.snapshots().listen((postsSnapshot) {
  //     if (postsSnapshot.documents.isNotEmpty) {
  //       var posts =
  //           .toList();

  //       // Add the posts onto the controller
  //       _postsController.add(posts);
  //     }
  //   });

  //   //return with geoflutter
  // }
}
