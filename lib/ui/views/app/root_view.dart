import 'package:animations/animations.dart';
import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:compound/viewmodels/root_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../icons/iconly.dart';
import 'package:compound/ui/views/app/home_view.dart';
import 'package:stacked/stacked.dart';

import 'camera_view.dart';

class RootView extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<RootView> {
  double yTransValue = 0;
  String tab = "home";

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    PageController _myPage = PageController(initialPage: 0);
    return ViewModelBuilder<RootViewModel>.reactive(
      builder: (context, model, child) =>
          NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          print(notification.metrics.axisDirection);
          print(notification.metrics.axis);

          if (notification.scrollDelta.sign == 1) {
            setState(() {
              yTransValue = 100;
            });
          } else if (notification.scrollDelta.sign == -1) {
            setState(() {
              yTransValue = 0;
            });
          }
        },
        child: Scaffold(
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(0, yTransValue, 0),
              height: 60,
              width: 5,
              child: SizedBox(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: null,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        iconSize: 25.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(
                          Iconly.home,
                          color: (() {
                          if (tab == "home") {
                            return Colors.black;
                          }

                          return Colors.grey;
                        })(),
                        ),
                        onPressed: () {
                          _myPage.jumpToPage(0);
                          setState(() {
                            tab = "home";
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 25.0,
                        padding: EdgeInsets.only(right: 28.0),
                        icon: Icon(Iconly.category, color: (() {
                          if (tab == "category") {
                            return Colors.black;
                          }

                          return Colors.grey;
                        })(),
                        ),
                        onPressed: () {
                          _myPage.jumpToPage(1);
                          setState(() {
                            tab = "category";
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 25.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(Iconly.notification, color: (() {
                          if (tab == "notification") {
                            return Colors.black;
                          }

                          return Colors.grey;
                        })(),),
                        onPressed: () {
                          _myPage.jumpToPage(2);
                          setState(() {
                            tab = "notification";
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 25.0,
                        padding: EdgeInsets.only(right: 28.0),
                        icon: Icon(Iconly.profile,color: (() {
                          if (tab == "profile") {
                            return Colors.black;
                          }

                          return Colors.grey;
                        })(),),
                        onPressed: () {
                          _myPage.jumpToPage(3);
                          setState(() {
                            tab = "profile";
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: PageView(
            controller: _myPage,
            onPageChanged: (int) {
              print('Page Changes to index $int');
            },
            children: <Widget>[
              HomeView(),
              Center(
                child: Container(
                  child: Text('Empty Body 1'),
                ),
              ),
              Center(
                child: Container(
                  child: Text('Empty Body 2'),
                ),
              ),
              Center(
                child: Container(
                  child: Text('Empty Body 3'),
                ),
              )
            ],
// Comment this if you need to use Swipe.
          ),
          floatingActionButton: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(0, yTransValue * 2, 0),
            height: 65.0,
            width: 65.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  _navigationService.navigateTo(CameraViewRoute);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),

                backgroundColor: Color.fromARGB(255, 90, 49, 244),
                child: Icon(
                  Iconly.camera,
                  color: Colors.white,
                ),
                // elevation: 5.0,
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => RootViewModel(),
    );
  }

  
}
