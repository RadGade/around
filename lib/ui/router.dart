import 'package:compound/ui/views/app/camera_view.dart';
import 'package:compound/ui/views/app/home_view.dart';
import 'package:flutter/material.dart';
import 'package:compound/constants/route_names.dart';
import 'package:compound/ui/views/login_view.dart';
import 'package:compound/ui/views/signup_view.dart';
import 'package:compound/ui/views/app/root_view.dart';

import 'views/auth_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AuthView(),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CameraViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CameraView(),
      );

    case RootViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RootView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
