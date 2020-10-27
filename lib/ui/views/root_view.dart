import 'package:animations/animations.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:compound/viewmodels/root_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:compound/ui/views/home_view.dart';
import 'package:stacked/stacked.dart';

import 'camera_view.dart';

class RootView extends StatelessWidget {
  const RootView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RootViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[800],
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Todos',
              icon: Icon(Icons.art_track),
            ),
            BottomNavigationBarItem(
              label: 'Create',
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => RootViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return CameraView();
      default:
        return HomeView();
    }
  }
}
