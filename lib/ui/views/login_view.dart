import '../shared/text_field.dart';
import 'package:compound/icons/iconly.dart';
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

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromARGB(255, 90, 49, 244),
          // appBar: AppBar(
          //   iconTheme: IconButton(icon: Icon(Iconly.arrow___left_2,), onPressed: () {  },)
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      textScaleFactor: 4,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                verticalSpaceLarge,
                Column(
                  children: [
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
      verticalSpaceSmall,
              InputField(
                placeholder: 'Password',
                password: true,
                controller: passwordController,
                additionalNote: 'Password has to be a minimum of 6 characters.',
              ),
                  ],
                ),
                Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                           child: !model.busy
              ?  Text(
                            "Log in",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                            ),
                          ): CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 90, 49, 244))),
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
                            model.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
                verticalSpaceMedium,
                TextLink(
                  'Create an Account if you\'re new.',
                  onPressed: () {
                    _navigationService.navigateTo(SignUpViewRoute);
                  },
                )
              ],
            ),
          )),
    );
  }
}
