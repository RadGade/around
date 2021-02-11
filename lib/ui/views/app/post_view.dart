import 'package:compound/constants/route_names.dart';
import 'package:compound/icons/iconly.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import '../../../locator.dart';
import './tik_tok_icons.dart';

class Post_view extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double ActionWidgetSize = 60.0;
  static const double ActionIconSize = 35.0;
  static const double ShareActionIconSize = 25.0;
  static const double ProfileImageSize = 50.0;
  static const double ActionIconGap = 12.0;
  static const double FollowActionIconSize = 25.0;
  static const double CreateButtonWidth = 38.0;
  String path;
  Post_view(this.path);



  Widget get videoDescription => Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                '@firstjonny',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                height: 10.0,
              ),
              Text('Video title and some other stuff', style: TextStyle(color: Colors.white),),
              Container(
                height: 10.0,
              ),
              Row(children: [
                Icon(Icons.music_note, color: Colors.white, size: 15.0),
                Container(
                  width: 10.0,
                ),
                Text('Artist name', style: TextStyle(fontSize: 12.0, color: Colors.white)),
                Container(
                  width: 10.0,
                ),
                Text('Song name', style: TextStyle(fontSize: 12.0, color: Colors.white))
              ]),
              Container(
                height: 12.0,
              ),
            ]),
      ));

  Widget get actionsToolbar => Container(
    width: 100.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        _getVideoAction(title: '', icon: Iconly.heart),
        _getVideoAction(title: '', icon: Iconly.bookmark),
        _getVideoAction(title: '', icon: Iconly.chat),
        _getVideoAction(
            title: '', icon: Iconly.send, isShare: true),
        _getProfileVideoAction(),
      ],
    ),
  );

  LinearGradient get musicGradient => LinearGradient(colors: [
    Colors.grey[800],
    Colors.grey[900],
    Colors.grey[900],
    Colors.grey[800]
  ], stops: [
    0.0,
    0.4,
    0.6,
    1.0
  ], begin: Alignment.bottomLeft, end: Alignment.topRight);



  Widget get centerSection => Expanded(
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[videoDescription, actionsToolbar]));

  Widget get customCreateIcon => Container(
      width: 45.0,
      height: 27.0,
      child: Stack(children: [
        Container(
            margin: EdgeInsets.only(left: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0))),
        Container(
            margin: EdgeInsets.only(right: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0))),
        Center(
            child: Container(
              height: double.infinity,
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
              child: Icon(
                Icons.add,
                size: 20.0,
              ),
            )),
      ]));



  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return Scaffold(
      body: Container(
        child: Stack(
          children : <Widget>[

        Center(
                    child: Image.network(
                      path,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
            Column(
          children: <Widget>[

            centerSection,
            Opacity(
                opacity: 0.1,
                child: Container(height: 5.0, color: Colors.grey[600])),

          ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30, left : 10), child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Iconly.arrow___left,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),)
              ],
            ),])
      ),
    );
  }

  Widget _getVideoAction({String title, IconData icon, bool isShare = false}) {
    return Container(
        margin: EdgeInsets.only(top: 15.0),
        width: ActionWidgetSize,
        height: ActionWidgetSize,
        child: Column(children: [
          Icon(icon,
              size: isShare ? ShareActionIconSize : ActionIconSize,
              color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.only(top: isShare ? 5.0 : 2.0),
            child:
            Text(title, style: TextStyle(fontSize: isShare ? 10.0 : 12.0)),
          )
        ]));
  }

  Widget _getProfileVideoAction({String pictureUrl}) {
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10.0),
          width: ActionWidgetSize,
          height: ActionWidgetSize,
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(1.0),
              height: ProfileImageSize,
              width: ProfileImageSize,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
              child: CachedNetworkImage(
                imageUrl:
                "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ])),
      Positioned(
          width: 15.0,
          height: 15.0,
          bottom: 5,
          left: ((ActionWidgetSize / 2) - (15 / 2)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          )),
      Positioned(
          bottom: 0,
          left: ((ActionWidgetSize / 2) - (FollowActionIconSize / 2)),
          child: Icon(Icons.add_circle,
              color: Color.fromARGB(255, 90, 49, 244),
              size: FollowActionIconSize))
    ]);
  }
}



// class Post_view extends StatelessWidget {
//   String path;
//   Post_view(this.path);
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<PostViewModel>.reactive(
//         viewModelBuilder: () => PostViewModel(),
//         builder: (context, model, child) => Stack(
//               children: [
//                 GestureDetector(
//                   onVerticalDragUpdate: (dragUpdateDetails) {
//                     Navigator.of(context).pop();
//                   },
//                   child: Center(
//                     child: Image.network(
//                       path,
//                       fit: BoxFit.cover,
//                       height: double.infinity,
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ));
//   }
// }
