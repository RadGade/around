import 'package:compound/viewmodels/root_viewmodel.dart';
import 'package:compound/viewmodels/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'signup_flow/accept_permission.dart';
import 'signup_flow/birthdate_view.dart';
import 'signup_flow/email_view.dart';
import 'signup_flow/password_view.dart';
import 'signup_flow/username_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
  }

  PageController _myPage;
  int currentIndex = 0;
  String email = "";
  DateTime birthday;
  String username = "";
  String password = "";
  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  nextFunction() {
    _myPage.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void getFuncForIndex(int index) {
    switch (index) {
      case 0:
        {
          String data = "something";
          print(data);
        }
        break;
      case 1:
        {
          print(email);
        }
        break;
      case 2:
        {
          print(birthday);
        }
        break;
      case 3:
        {
          print(username);
        }
        break;
      case 4:
        {
          print(password);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          PageView(
            controller: _myPage,
            physics: new NeverScrollableScrollPhysics(),
            onPageChanged: onChangedFunction,
            children: <Widget>[
              Accept_Permission(),
              Email_View(
                onEmailChanged: (String newEmail) {
                  email = newEmail;
                },
              ),
              Birthdate_View(
                onBirthdayChanged: (DateTime newDate) {
                  birthday = newDate;
                },
              ),
              Username_View(
                onUsernameChanged: (String newUsername) {
                  username = newUsername;
                },
              ),
              Password_View(
                onPasswordChanged: (String newPassword) {
                  password = newPassword;
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 50.0),
                    child: FlatButton(
                      child: Text(
                        (() {
                          if (currentIndex == 4) {
                            return "Let's go";
                          }

                          return "Next";
                        })(),
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      color: Colors.white,
                      textColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        (() async {
                          if (currentIndex == 4) {
                            model.signUp(email: email, password: password, username: username, birthday: birthday);
                            
                          } else if (currentIndex == 0) {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.location,
                              Permission.storage,
                              Permission.camera,
                              Permission.notification,
                              Permission.sensors
                              
                            ].request();
                            print(statuses[Permission.location]);
                            nextFunction();
                          }

                          return nextFunction();
                        })();
                      },
                    ),
                  ),
                ]),
          )
        ],
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }

  @override
  void dispose() {
    _myPage.dispose();
    super.dispose();
  }
}

//   onPressed: () {
//     _myPage.jumpToPage(0);
//   },
