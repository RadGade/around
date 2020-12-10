import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:compound/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/viewmodels/login_view_model.dart';

class AuthView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromARGB(255, 90, 49, 244),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                verticalSpaceMassive,
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/Logo.png'),
                  ),
                ),
                Column(
                  children: [
                    verticalSpaceMassive,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text("Log in", textScaleFactor: 1.5,  style: TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w900,
  ),),
                          color: Colors.white,
                          textColor: Colors.black,
                           padding: EdgeInsets.symmetric(
                              horizontal: 45, vertical: 15),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
 _navigationService.navigateTo(LoginViewRoute);
                          },
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text("Sign up", textScaleFactor: 1.5,  style: TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w900,
  ),),
                          textColor: Colors.white,
                           padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                    _navigationService.navigateTo(SignUpViewRoute);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                // verticalSpaceMedium,
                // TextLink(
                //   'Create an Account if you\'re new.',
                //   onPressed: () {
                //     _navigationService.navigateTo(SignUpViewRoute);
                //   },
                // )
              ],
            ),
          )),
    );
  }
}

                    // BusyButton(
                    //   title: 'Login',
                    //   busy: model.busy,
                    //   onPressed: () {
                    //     model.login(
                    //       email: emailController.text,
                    //       password: passwordController.text,
                    //     );
                    //   },
                    // )