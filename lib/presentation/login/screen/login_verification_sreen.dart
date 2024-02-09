import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/login/bloc/login_bloc.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/utils/asset_image_path_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:core/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/app_route_name.dart';

class LoginVerificationScreen extends StatefulWidget {
  final String verificationId;

  LoginVerificationScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  var otpController = List.generate(6, (index) => TextEditingController());
  late LoginBloc bloc;

  bool enableButton = false;
  int valueCounter = 0;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 74.0),
          child: _topLayout(),
        )),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            height: AppConstants.buttonHeight,
            child: ButtonWidget(
              buttonText: "Submit",
              isEnabled: enableButton,
              onTapEvent: () {
                String otpEntered = "";

                for (var otp in otpController) {
                  otpEntered = otpEntered + otp.value.text;
                }
                bloc.add(
                  LoginOtpEvent(
                    otpCode: otpEntered,
                    verificationId: widget.verificationId,
                  ),
                );
              },
              followIcon: AssetImagePath.arrowRightWhiteIcon,
            ),
          ),
        )
      ],
    );
  }

  Widget _topLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boxLayout(),
        TextButton(onPressed: () {}, child: Text("Resend")),
        const Center(
          child: TimerWidget(
            duration: Duration(minutes: 2),
          ),
        ),
      ],
    );
  }

  Widget _boxLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) => otpBoxBuilder(index)),
    );
  }

  Widget otpBoxBuilder(int index) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 40,
      child: TextField(
        controller: otpController[index],
        onChanged: (value) {
          if (value.length == 1 && index <= 4) {
            valueCounter++;
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
            valueCounter--;
          } else if (value.length == 1 && index == 5) {
            valueCounter++;
            FocusScope.of(context).unfocus();
          } else if (value.isEmpty && index == 0) {
            valueCounter--;
          }
          if (valueCounter == 6) {
            setState(() {
              enableButton = true;
            });
          } else {
            setState(() {
              enableButton = false;
            });
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
