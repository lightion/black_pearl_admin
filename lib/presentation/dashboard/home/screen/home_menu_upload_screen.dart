import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/dashboard/home/bloc/home_menu_bloc.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:core/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  final bloc = HomeMenuBloc();

  final loadingOverlay = LoadingOverlay(
    color: ColorConstants.electricBlue,
    isOverlay: true,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<HomeMenuBloc, HomeMenuState>(
        listener: (context, state) async {
          if (state is HomeMenuLoading) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
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
            backgroundColor: ColorConstants.antiFlashWhite,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is HomeMenuImageSelectedSuccess && state.path != ''
                      ? _imagePickerSuccessWidget(state.path)
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      width: double.infinity,
                      height: AppConstants.buttonHeight,
                      child: OutlinedButtonWidget(
                        onTapEvent: () { bloc.add(HomeMenuImagePickerClickedEvent());},
                        text: "Select From Gallery",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imagePickerSuccessWidget(String path) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 500, width: 400, child: Image.file(File(path))),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            width: double.infinity,
            height: AppConstants.buttonHeight,
            child: OutlinedButtonWidget(
              onTapEvent: (){},
              text: "Upload",
            ),
          ),
        ),
      ],
    );
  }
}
