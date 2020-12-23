import 'package:camera/camera.dart';
import 'package:compound/ui/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/views/auth_view.dart';
import 'ui/views/app/root_view.dart';
import 'ui/views/startup_view.dart';

List<CameraDescription> cameras;

bool log = false;
void main() async {
  // Register all the models and services before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
    await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user.email != null) {
      log = true;
      print(user);
    }
  });
  cameras = await availableCameras();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'around',
       debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
        home: AuthView(),
      onGenerateRoute: generateRoute,
    );
  }
}


            