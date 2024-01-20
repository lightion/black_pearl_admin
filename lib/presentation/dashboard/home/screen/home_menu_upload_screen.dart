import 'package:beamer/beamer.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
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
        backgroundColor: Colors.transparent,
        hideAppBar: true,
      ),
      backgroundColor: ColorConstants.antiFlashWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              width: double.infinity,
              height: AppConstants.buttonHeight,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: ColorConstants.electricBlue),
                ),
                child: Text(
                  "Upload",
                  textAlign: TextAlign.center,
                  style: Styles.h5w600.merge(const TextStyle(
                    color: ColorConstants.electricBlue,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
