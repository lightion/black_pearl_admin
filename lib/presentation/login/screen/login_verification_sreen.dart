import 'package:beamer/beamer.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class LoginVerificationScreen extends StatefulWidget {
  const LoginVerificationScreen({super.key});

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  var otpController = List.generate(4, (index) => TextEditingController());

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
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 74.0),
            child: _topLayout(),
          )),
          ButtonWidget(
              buttonText: "Submit", isEnabled: false, onTapEvent: () {})
        ],
      ),
    );
  }

  Widget _topLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boxLayout(),
        TextButton(onPressed: () {}, child: Text("Resend")),
      ],
    );
  }

  Widget _boxLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) => otpBoxBuilder(index)),
    );
  }

  Widget otpBoxBuilder(int index) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      child: TextField(
        controller: otpController[index],
        onChanged: (value) {
          if (value.length == 1 && index <= 3) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            filled: true,
            fillColor: ColorConstants.lavenderMist),
        textAlign: TextAlign.center,
      ),
    );
  }
}
