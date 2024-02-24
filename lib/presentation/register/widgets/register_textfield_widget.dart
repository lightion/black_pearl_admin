import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

class RegisterTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  final String hintText;

  final Icon prefixIcon;

  final TextInputType? textInputType;

  const RegisterTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    this.textInputType,
  });

  @override
  State<RegisterTextFieldWidget> createState() =>
      _RegisterTextFieldWidgetState();
}

class _RegisterTextFieldWidgetState extends State<RegisterTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: widget.textEditingController,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            prefixIconColor: ColorConstants.labelTextColor,
            labelText: widget.hintText,
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
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}
