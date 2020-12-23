import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeoFirestoreService {
  FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference _postsCollectionReference =
      // ignore: deprecated_member_use
      Firestore.instance.collection("posts");
  final CollectionReference _usersCollectionReference =
      // ignore: deprecated_member_use
      Firestore.instance.collection('users');
  final Location location = new Location();
  // ignore: close_sinks
  final radius = 0.500;
  final Geoflutterfire geo = Geoflutterfire();

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future<DocumentReference> addPost(Post post) async {
    final User user = auth.currentUser;
    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    post.postion = await point.data;
    post.userId = user.uid;
    return _postsCollectionReference.add(post.toMap());
  }

  Future createUser(newUser user) async {
    try {
      // ignore: deprecated_member_use
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getPostsOnceOff() async {
    var pos = await location.getLocation();
    print(pos);
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
