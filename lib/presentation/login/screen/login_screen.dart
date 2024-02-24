import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/login/bloc/login_bloc.dart';
import 'package:black_pearl/presentation/login/widgets/login_mobile_widget.dart';
import 'package:black_pearl/presentation/routes/app_route_name.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/constants/string_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = getIt<LoginBloc>();
  late TextEditingController textEditingController;
  final loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc..add(LoginInitialEvent()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoadingState) {
            loadingOverlay.show(context);
          } else if (state is LoginErrorState) {
            loadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is LoginMobileSuccessState) {
            loadingOverlay.hide();
            context.beamToNamed(AppRouteName.loginVerification, data: {
              "verificationId": state.verificationId,
              "mobileNumber": state.mobileNumber
            });
          }
          if (state is LoginSuccessState) {
            loadingOverlay.hide();
            context.beamToNamed(AppRouteName.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //TODO: Add Logo for the application
                const Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 27.0),
                        child: CircleAvatar(
                          radius: AppConstants.loginLogoRadius,
                          backgroundImage: NetworkImage(
                              'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstants.logInTitle,
                            style: Styles.h2w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 16, right: 16),
                    child: LoginMobileWidget(
                      buttonText: "Continue",
                      textEditingController: textEditingController,
                      onTapEvent: () {
                        String mobileNumber = textEditingController.value.text;
                        bloc.add(LoginAttemptEvent(mobileNumber: mobileNumber));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
