import 'package:core/constants/app_constants.dart';
import 'package:core/constants/string_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/utils/asset_image_path_constants.dart';
import 'package:flutter/material.dart';
import 'package:core/widgets/button_widget.dart';

class LoginMobileWidget extends StatefulWidget {
  final String buttonText;

  final VoidCallback onTapEvent;

  const LoginMobileWidget({
    super.key,
    required this.buttonText,
    required this.onTapEvent,
  });

  @override
  State<LoginMobileWidget> createState() => _LoginMobileWidgetState();
}

class _LoginMobileWidgetState extends State<LoginMobileWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '+91-',
              style: Styles.h5w400,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: StringConstants.mobileHint,
                  ),
                  style: Styles.h5w400,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: const Alignment(0.0, 0.8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                valueListenable: textEditingController,
                builder: (context, value, child) {
                  return SizedBox(
                    height: AppConstants.buttonHeight,
                    width: double.infinity,
                    child: ButtonWidget(
                      buttonText: widget.buttonText,
                      isEnabled: value.text.length == 10,
                      onTapEvent: widget.onTapEvent,
                      followIcon: AssetImagePath.loginButtonIcon,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
