import 'package:compound/icons/iconly.dart';
import 'package:compound/ui/views/app/post_view.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../locator.dart';

class CollectionView extends StatefulWidget {
  CollectionView({Key key}) : super(key: key);

  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
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
         appBar:                     AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        title: Builder(
                          builder: (BuildContext context) {
                            return Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Collection",
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
                      ),
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
            :   
           ListView(
             padding: const EdgeInsets.all(8),
  children: <Widget>[
   Container(
   padding: EdgeInsets.fromLTRB(10,10,10,0),
   height: 220,
   width: double.maxFinite,
   
   child: Card(
     elevation: 5,
     
     child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.yellow, Colors.orange])
  ),
     ),
   )),
   Container(
   padding: EdgeInsets.fromLTRB(10,10,10,0),
   height: 220,
   width: double.maxFinite,
   
   child: Card(
     elevation: 5,
     
     child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.orange, Colors.pink])
  ),
     ),
   )),
   Container(
   padding: EdgeInsets.fromLTRB(10,10,10,0),
   height: 220,
   width: double.maxFinite,
   
   child: Card(
     elevation: 5,
     
     child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.purple, Colors.blue])
  ),
     ),
   )),
  ],
           )

    ),
      

      // 2. register viewmodel as singleton and get from locator
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}
