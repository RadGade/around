import 'package:compound/icons/iconly.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/views/app/post_view.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../locator.dart';

class AccountView extends StatefulWidget {
  AccountView({Key key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  @override
  Widget build(BuildContext context) {
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
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.purple[200]),
                    ),
                    Text(
                      'Loading Posts',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            : ListView(
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
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Gerald",
                                    textScaleFactor: 1.5,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Gilroy",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        actions: <Widget>[
                          // ignore: missing_required_param
                          Container(
                            margin: EdgeInsets.only(right: 15.0),
                            child: IconButton(
                              icon: Icon(
                                Iconly.add_user,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(left: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 12.0),
                                    height: 100,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://mms.businesswire.com/media/20180320005991/en/646972/5/NBA-Headspace_Illustration_FINAL.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 15.0, top: 10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    height: 40,
                                    width: 220,
                                    child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                          
                                            Text("Posts"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("3")
                                          ],
                                        ),
                                         horizontalSpaceMedium,
                                         Column(
                                          children: [
                                            Text("Likes"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("3k")
                                          ],
                                        ),
                                        horizontalSpaceMedium,
                                        Column(
                                          children: [
                                            Text("Freinds"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("3k")
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]),
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
                              return Container(
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
                              );
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
              ),
      ),

      // 2. register viewmodel as singleton and get from locator
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}
