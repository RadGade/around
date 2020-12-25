import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/viewmodels/startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () =>  StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder : (context, model, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 90, 49, 244),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width : 300,
                height : 100,
                child: Image.asset('assets/images/Logo.png')
              ),
              CircularProgressIndicator(
                strokeWidth : 3,
                valueColor : AlwaysStoppedAnimation(Colors.white),
              )
            ],
          ),
        ),
      )
    );
  }
}