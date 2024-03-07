import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

class ProfileEditTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  final Icon prefixIcon;

  final String value;

  final String labelText;

  final bool isEnabled;

  final TextInputType inputType;

  const ProfileEditTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.prefixIcon,
    required this.value,
    required this.labelText,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
  });


  @override
  State<ProfileEditTextFieldWidget> createState() =>
      _ProfileEditTextFieldWidgetState();
}

class _ProfileEditTextFieldWidgetState
    extends State<ProfileEditTextFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: widget.textEditingController,
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            prefixIconColor: ColorConstants.labelTextColor,
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: ColorConstants.labelTextColor,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide:
              BorderSide(color: ColorConstants.lavenderMist, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide:
              BorderSide(color: ColorConstants.lavenderMist, width: 2),
            ),
          ),
          style: Styles.h5w400,
          keyboardType: widget.inputType,
        ),
      ),
    );
  }
}