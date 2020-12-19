
import 'package:compound/viewmodels/root_viewmodel.dart';
import 'package:flutter/material.dart';
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
        void _askPermission() {
          
        }
        return ;
      case 1:
        return print(1);
      case 2:
        return print(2);
      case 3:
        return print(3);
      case 4:
        return print(4);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return ViewModelBuilder<RootViewModel>.reactive(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          PageView(
            controller: _myPage,
            physics:new NeverScrollableScrollPhysics(),
            onPageChanged: onChangedFunction,
            children: <Widget>[
              Accept_Permission(),
              Email_View(),
              Birthdate_View(),
              Username_View(),
              Password_View()
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
                        getFuncForIndex(currentIndex);
                        nextFunction();
                      },
                    ),
                  ),
                ]),
          )
        ],
      ),
      viewModelBuilder: () => RootViewModel(),
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
