import 'package:flutter/material.dart';

import '../theme/color_constants.dart';
import '../theme/styles.dart';

class ButtonWidget extends StatefulWidget {
  final String buttonText;
  final bool isEnabled;
  final VoidCallback onTapEvent;
  final Icon? followIcon;

  const ButtonWidget({
    required this.buttonText,
    required this.isEnabled,
    required this.onTapEvent,
    this.followIcon,
    super.key,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final foregroundColor =
        MaterialStateProperty.resolveWith<Color>(_getForegroundColor);

    final backgroundColor =
        MaterialStateProperty.resolveWith<Color>(_getBackgroundColor);

    final buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
    return ElevatedButton(
      style: buttonStyle,
      onPressed: widget.isEnabled ? widget.onTapEvent : null,
      child: Text(
        widget.buttonText,
        style: Styles.h5w400,
      ),
    );
  }

  Color _getForegroundColor(Set<MaterialState> states) {
    return Colors.white;
  }

  Color _getBackgroundColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
    };
    if (states.contains(MaterialState.disabled)) {
      return ColorConstants.gray50;
    } else if (states.any(interactiveStates.contains)) {
      return ColorConstants.buttonPressed;
    } else {
      return ColorConstants.electricBlue;
    }
  }
}
