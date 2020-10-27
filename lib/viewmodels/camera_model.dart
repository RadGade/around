import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera_Model {
  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
  }
}
