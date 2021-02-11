import 'dart:math';

import 'package:compound/constants/route_names.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../locator.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(90, 49, 244, opacity);

    double size = rect.width / 1.5;
    double area = size * size;
    double radius = sqrt(area * value / 2);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class NearbyFriendView extends StatefulWidget {
  @override
  SpriteDemoState createState() => new SpriteDemoState();
}

class SpriteDemoState extends State<NearbyFriendView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
    _startAnimation();
    //_startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return Scaffold(
        backgroundColor:  Colors.grey[900],
        body: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15), child: GestureDetector(
                  onTap: () {
                    _navigationService.navigateTo(RootViewRoute);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomPaint(
                      painter: new SpritePainter(_controller),
                      child: new SizedBox(
                        width: 200.0,
                        height: 200.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],

    ),
    );
  }
}