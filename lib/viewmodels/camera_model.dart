import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter/material.dart';
import 'base_model.dart';
import 'package:stacked/stacked.dart';

 class CameraViewModel extends BaseModel {

  List<CameraDescription> _camera = [];
  List<CameraDescription> get cameras => _camera;
  
  CameraController _controller;
  CameraController get controller => _controller;


  Future<CameraDescription> getCamera() async {
    setBusy(true);
    _camera = await availableCameras();
    _controller = CameraController(
      _camera.first,
      ResolutionPreset.medium,
    );
     await _controller.initialize().then((value) => {
       
       setBusy(false)
     });
    
    print(_controller.value.aspectRatio);
  }
  
}
