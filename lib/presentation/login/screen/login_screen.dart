import 'package:black_pearl/presentation/login/widgets/login_mobile_widget.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/constants/string_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TODO: Add Logo for the application
          CircleAvatar(
            radius: AppConstants.loginLogoRadius,
            backgroundImage: NetworkImage(
                'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConstants.logInTitle,
                  style: Styles.h2w700,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 16, right: 16),
            child: LoginMobileWidget(
              buttonText: "Continue",
              onTapEvent: () {},
            ),
          ),
        ],
      ),
    );
  }
}
