import 'package:flutter/material.dart';

import '../theme/color_constants.dart';
import '../theme/styles.dart';

class OutlinedButtonWidget extends StatelessWidget {

  final VoidCallback onTapEvent;
  final String text;

  const OutlinedButtonWidget({required this.onTapEvent, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTapEvent,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(
            color: ColorConstants.electricBlue),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Styles.h5w600.merge(const TextStyle(
          color: ColorConstants.electricBlue,
        )),
      ),
    );
  }
}
