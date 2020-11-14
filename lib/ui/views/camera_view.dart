import 'package:compound/constants/route_names.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/ui/views/preview_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/viewmodels/camera_model.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class CameraView extends StatefulWidget {
  CameraView({Key key, this.controller}) : super(key: key);

  final PageController controller;
  final double iconHeight = 30;
  final PageController bottomPageController =
      PageController(viewportFraction: .2);

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  final NavigationService _navigationService = locator<NavigationService>();
  CameraController _controller;
  Future<void> _controllerInizializer;
  double cameraHorizontalPosition = 0;

  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
  }

  @override
  void initState() {
    super.initState();

    getCamera().then((camera) {
      if (camera == null) return;
      setState(() {
        _controller = CameraController(
          camera,
          ResolutionPreset.high,
        );
        _controllerInizializer = _controller.initialize();
        _controllerInizializer.whenComplete(() {
          setState(() {
            cameraHorizontalPosition = -(MediaQuery.of(context).size.width *
                    _controller.value.aspectRatio) /
                2;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose().then((value) => print("camera disposed"));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          /* trying to preserve aspect ratio */
          left: cameraHorizontalPosition,
          right: cameraHorizontalPosition,
          child: FutureBuilder(
            future: _controllerInizializer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final size = MediaQuery.of(context).size;
                return ClipRect(
                  child: Container(
                    child: Transform.scale(
                      scale: _controller.value.aspectRatio / size.aspectRatio,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 50,
                    right: 40,
                    left: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            try {
                              await _controllerInizializer;
                              final path = join(
                                (await getTemporaryDirectory()).path,
                                '${DateTime.now()}.png',
                              );
                              print(path);
                              await _controller.takePicture(path).then(
                                  (value) async => await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Preview_view(path);
                                      })));
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 90, 49, 244),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(45),
                                ),
                              ),
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(105),
                              ),
                              border: Border.all(
                                width: 20,
                                color: Colors.black.withOpacity(.45),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: 30,
                  child: GestureDetector(
                    onTap: () {
                      _navigationService.navigateTo(RootViewRoute);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
