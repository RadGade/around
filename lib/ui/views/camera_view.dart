import 'package:compound/constants/route_names.dart';
import 'package:compound/services/navigation_service.dart';
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
    _controller.dispose();
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: widget.iconHeight,
                          child: Icon(
                            Icons.flash_on,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Take the Picture in a try / catch block. If anything goes wrong,
                            // catch the error.
                            try {
                              // Ensure that the camera is initialized.
                              await _controllerInizializer;
                              // Construct the path where the image should be saved using the path
                              // package.
                              final path = join(
                                // Store the picture in the temp directory.
                                // Find the temp directory using the `path_provider` plugin.
                                (await getTemporaryDirectory()).path,
                                '${DateTime.now()}.png',
                              );
                              print(path);
                              // Attempt to take a picture and log where it's been saved.
                              await _controller.takePicture(path);
                              // await showDialog(
                              //     context: context,
                              //     builder: (_) => Preview(path));
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              border: Border.all(
                                width: 10,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: widget.iconHeight,
                          child: Icon(
                            Icons.cached,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigationService.navigateTo(HomeViewRoute);
                          },
                          child: Icon(
                            Icons.tag_faces,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 10,
                    height: 20,
                    child: PageView.builder(
                      controller: widget.bottomPageController,
                      itemBuilder: (context, index) {
                        return Text(
                          "Item $index",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        );
                      },
                      itemCount: 20,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                    ),
                  )
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
