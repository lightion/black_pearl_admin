import 'dart:convert';
import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/dashboard/home/bloc/home_menu_bloc.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/enums/menu_type.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:core/widgets/outlined_button_widget.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeMenuScreen extends StatefulWidget {
  final MenuType menuType;

  const HomeMenuScreen({
    super.key,
    required this.menuType,
  });

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  XFile? image;

  final SharedPreferenceService preference = getIt<SharedPreferenceService>();

  final bloc = HomeMenuBloc(
    preference: getIt<SharedPreferenceService>(),
    addMenuUseCase: getIt<PostAddMenuUseCase>(),
  );

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
          if (state is HomeMenuImageSelectedSuccess) {
            image = state.pickedFile;
          }

          if (state is HomeMenuErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          if (state is HomeMenuImageUploadSuccessState) {
            Beamer.of(context).beamBack();
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
                        onTapEvent: () {
                          bloc.add(HomeMenuImagePickerClickedEvent());
                        },
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
              onTapEvent: () async {
                final String restaurantId =
                    await preference.readSecureData(AppConstants.prefId) ?? "";
                List<int>? imageBytes =
                    image != null ? await image!.readAsBytes() : null;
                if (image == null) {
                  print("Image is coming as null");
                }
                print("image bytes: $imageBytes");
                bloc.add(HomeMenuUploadImageEvent(
                    request: AddMenuPostRequest(
                  restaurantId:
                      restaurantId.isNotEmpty ? int.parse(restaurantId) : 0,
                  menuType:
                      widget.menuType == MenuType.lunch ? "lunch" : "dinner",
                  restaurant: null,
                  menuImageURL: image != null
                      ? "data:image/png;base64, ${base64Encode(imageBytes!)}"
                      : "",
                )));
              },
              text: "Upload",
            ),
          ),
        ),
      ],
    );
  }
}
