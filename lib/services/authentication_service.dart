import 'package:compound/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:compound/services/firestore_service.dart';
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String username,
    @required DateTime birthday,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
            await GeoFirestoreService().createUser(newUser(
          id: authResult.user.uid,
          email: email,
          username: username,
          birthday: birthday));
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }


    Future<bool> isUserLoggedIn() async {
    var user =  _firebaseAuth.currentUser;
    return user != null;
  }
}
