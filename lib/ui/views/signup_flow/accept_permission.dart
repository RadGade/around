import 'package:compound/constants/route_names.dart';
import 'package:compound/icons/iconly.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/ui/base_widget.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/busy_button.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:compound/viewmodels/signup_view_model.dart';

class Accept_Permission extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => BaseWidget(
      builder: (context, sizingInformation) {
        return
                Scaffold(
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
                    verticalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          textScaleFactor: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 150,
                        child: Image.asset('assets/images/authflow_asset.png'),
                      ),
                    ),
                    verticalSpaceLarge,
                    verticalSpaceSmall,
                    Text(
                      '''Enable app permissions to 
        make sign up easy''',
                      textScaleFactor: 1.2,
                      maxLines: 20,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    verticalSpaceLarge,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ],
                ),
              ),
            );
      }));
  }
}
