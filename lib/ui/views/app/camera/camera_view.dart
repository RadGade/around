import 'package:compound/constants/route_names.dart';
import 'package:compound/icons/iconly.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/viewmodels/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter_better_camera/new/src/camera_controller.dart';
import 'package:stacked/stacked.dart';

import 'widgets/CaptureButton.dart';
import 'widgets/ZoomableWidget.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return ViewModelBuilder<CameraViewModel>.reactive(
      builder: (context, model, child) => model.busy
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.purple[200]),
            ),
          ],
        ),
      )
          : Stack(children: [
              ZoomableWidget(
                  child: buildCameraView(model.controller, context),
                  onZoom: (zoom) {
                    print('zoom');
                    if (zoom < 11) {
                      model.controller.zoom(zoom);
                    }
                  }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _navigationService.navigateTo(RootViewRoute);
                          },
                          child: Icon(
                            Iconly.star,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: LoadingButton()),
                      ],
                    ),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ;
                          },
                          child: Icon(
                            Iconly.logout,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _navigationService.navigateTo(RootViewRoute);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      viewModelBuilder: () => CameraViewModel(),
      onModelReady: (model) => model.getCamera(),
    );
  }
}

Widget buildCameraView(controller, context) {
  final size = MediaQuery.of(context).size;
  double cameraHorizontalPosition = 0;
  cameraHorizontalPosition =
      -(MediaQuery.of(context).size.width * controller.value.aspectRatio) / 2;
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Positioned.fill(
          /* trying to preserve aspect ratio */
          left: cameraHorizontalPosition,
          right: cameraHorizontalPosition,
          child: ClipRect(
            child: Container(
              child: Transform.scale(
                scale: controller.value.aspectRatio / size.aspectRatio,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          )),
    ],
  );
}
