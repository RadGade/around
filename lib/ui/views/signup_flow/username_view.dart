import 'package:compound/constants/route_names.dart';
import 'package:compound/icons/iconly.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/viewmodels/signup_view_model.dart';

class Username_View extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Color.fromARGB(255, 90, 49, 244),
              appBar: AppBar(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Iconly.arrow___left, color: Colors.white),
                      onPressed: () {
                        _navigationService.navigateTo(AuthViewRoute);
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    verticalSpaceMassive,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Your Username",
                          textScaleFactor: 2.5,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
              InputField(
                placeholder: 'Username',
                controller: emailController,
              ),

                  ],
                ),
              ),
            ));
  }
}
