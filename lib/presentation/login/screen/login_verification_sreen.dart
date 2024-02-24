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

import '../../../di/injector.dart';
import '../../routes/app_route_name.dart';

class LoginVerificationScreen extends StatefulWidget {
  final Map<String, String> data;
  late final String verificationId;
  late final String mobileNumber;

  LoginVerificationScreen({super.key, required this.data}) {
    verificationId = data["verificationId"] ?? "";
    mobileNumber = data["mobileNumber"] ?? "";
  }

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  var otpController = List.generate(6, (index) => TextEditingController());
  late LoginBloc bloc;
  late LoadingOverlay loadingOverlay;

  bool enableButton = false;
  int valueCounter = 0;
  bool isTimedOut = false;

  @override
  void initState() {
    super.initState();
    bloc = getIt<LoginBloc>();
    loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoadingState) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is LoginSuccessState) {
            context.beamToNamed(AppRouteName.home);
          }
          if (state is LoginCheckState) {
            bloc.add(LoginCheckEvent(mobileNumber: widget.mobileNumber));
          }
          if (state is LoginRegistrationRequiredState) {
            context.beamToNamed(AppRouteName.register,
                data: widget.mobileNumber);
          }
          if (state is LoginTimedOutState) {
            isTimedOut = true;
          } else {
            isTimedOut = false;
          }
          if (state is LoginInitialState) {
            isTimedOut = false;
          }
        },
        builder: (context, state) {
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
            body: Column(
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
            ),
          );
        },
      ),
    );
  }

  Widget _topLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _boxLayout(),
        Visibility(
          visible: isTimedOut,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                bloc.add(LoginResendEvent(mobileNumber: widget.mobileNumber));
              },
              child: Text("Resend"),
            ),
          ),
        ),
        Center(
          child: Visibility(
              visible: !isTimedOut,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimerWidget(
                  duration: const Duration(minutes: 2),
                  whenComplete: () {
                    bloc.add(LoginTimedOutEvent());
                  },
                ),
              )),
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
