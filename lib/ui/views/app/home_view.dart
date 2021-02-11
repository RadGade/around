import 'dart:ui';

import 'package:compound/constants/route_names.dart';
import 'package:compound/icons/iconly.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/ui/base_widget.dart';
import 'package:compound/ui/screensize_info.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/views/app/nearby_freind.dart';
import 'package:compound/ui/views/app/post_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'OverlayableContainerOnLongPress.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return ViewModelBuilder<HomeViewModel>.reactive(
      // 1 dispose viewmodel
      disposeViewModel: false,
      // 3. set initialiseSpecialViewModelsOnce to true to indicate only initialising once
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey[900],
        body: model.isBusy
            ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple[200]),
              ),
            ],
          ),
        )
            : Container(
          child: ClipRect(        // Forces the OverlayEntry not to overflow this container
            child: Overlay(     // The Overlay that allows us to control the positioning
              initialEntries: <OverlayEntry>[
                OverlayEntry(
                  builder: (BuildContext context) {
                    return ListView(
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,

                              title: Builder(
                                builder: (BuildContext context) {
                                  return Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 15),
                                          child: SvgPicture.asset(
                                              "assets/images/toplogo.svg")),

                                      GestureDetector(
                                        child: Text(
                                          "around",
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Gilroy",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        onTap: (){
                                          model.posts;
                                        },
                                      ),
                                    ],
                                  );
                                },

                              ),
                              actions:
                              <Widget>[
                                IconButton(
                                  onPressed: () => {
                                    _navigationService.navigateTo(NearbyViewRoute)
                                  },
                                  icon: Icon(
                                    Iconly.add_user,
                                    color: Colors.white,
                                  ),
                                ),
                              ]
                              ,
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.all(12),
                              child: StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 0,
                                  itemCount: model.posts.length,
                                  itemBuilder: (context, index) {
                                    return ItemWidget(model: model, index: index,);
                                  },
                                  staggeredTileBuilder: (index) {
                                    return new StaggeredTile.count(
                                        1, index.isEven ? 1.2 : 1.8);
                                  }),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      // 2. register viewmodel as singleton and get from locator
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}

class ItemWidget extends StatelessWidget {
  ItemWidget({
    Key key,
    this.model,
    this.index,
  }): super(key: key);

  final  model;
  final int index;

  @override
  Widget build(BuildContext context){
    return OverlayableContainerOnLongPress(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius:
            BorderRadius.all(Radius.circular(12))),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) {
                  return Post_view(model.posts[index]);
                }));
          },
          child: ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(12)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: model.posts[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      overlayContentBuilder: (BuildContext context, VoidCallback onHideOverlay) {
        return Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: model.posts[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                ),
              ),)
          ],
        );
      },
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) {
              return Post_view(model.posts[index]);
            }));
      },
    );
  }

}