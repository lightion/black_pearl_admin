import 'package:beamer/beamer.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        message: "",
        leading: BackButton(
          color: ColorConstants.black,
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
        backgroundColor: Colors.white,
        hideAppBar: false,
        actionList: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              height: 35.0,
              width: 120.0,
              child: ButtonWidget(
                buttonText: "UPDATE",
                isEnabled: true,
                onTapEvent: () {},
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorConstants.antiFlashWhite,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: CircleAvatar(
                  radius: AppConstants.loginLogoRadius,
                  backgroundImage: NetworkImage(
                      'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
