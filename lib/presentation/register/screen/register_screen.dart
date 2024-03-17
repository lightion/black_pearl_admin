import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/register/bloc/register_bloc.dart';
import 'package:black_pearl/presentation/register/widgets/register_textfield_widget.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/utils/asset_image_path_constants.dart';
import 'package:core/utils/value_notifier.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/usecases/post_add_restaurant_usecase.dart';
import 'package:domain/usecases/post_upload_restaurant_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/app_route_name.dart';

class RegisterScreen extends StatefulWidget {
  final String mobileNumber;

  const RegisterScreen({super.key, required this.mobileNumber});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool enableButton = false;

  final bloc = RegisterBloc(
    addRestaurantUseCase: getIt<PostAddRestaurantUseCase>(),
    postUploadImageUseCase: getIt<PostUploadRestaurantImageUseCase>(),
    sharedPreference: getIt<SharedPreferenceService>(),
  );

  final loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  String imagePath = "";

  late TextEditingController nameTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController addressTextEditingController;

  @override
  void initState() {
    super.initState();
    nameTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterLoadingState) {
            loadingOverlay.show(context);
          } else {
            loadingOverlay.hide();
          }
          if (state is RegisterImageSelectedSuccessState) {
            imagePath = state.path;
          }
          if (state is RegisterFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is RegisterSuccessfulState) {
            context.beamToNamed(AppRouteName.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 0,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 64.0, bottom: 27.0),
                          child: GestureDetector(
                            child: CircleAvatar(
                              radius: AppConstants.loginLogoRadius,
                              backgroundImage: imagePath.isEmpty
                                  ? NetworkImage(
                                      'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg')
                                  : FileImage(File(imagePath)) as ImageProvider,
                            ),
                            onTap: () {
                              bloc.add(RegisterImageUploadEvent());
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegisterTextFieldWidget(
                              textEditingController: nameTextEditingController,
                              hintText: "Name",
                              prefixIcon: const Icon(Icons.restaurant),
                            ),
                            RegisterTextFieldWidget(
                              textEditingController: emailTextEditingController,
                              hintText: "e-mail",
                              prefixIcon: const Icon(Icons.email),
                              textInputType: TextInputType.emailAddress,
                            ),
                            RegisterTextFieldWidget(
                              textEditingController:
                                  addressTextEditingController,
                              hintText: "Address",
                              prefixIcon: const Icon(Icons.location_city),
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: ValuesNotifier([
                          nameTextEditingController,
                          emailTextEditingController,
                          addressTextEditingController,
                        ]),
                        builder: (_, __, ___) {
                          return Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: SizedBox(
                              height: AppConstants.buttonHeight,
                              child: ButtonWidget(
                                buttonText: "Register",
                                isEnabled: (nameTextEditingController
                                        .value.text.isNotEmpty &&
                                    emailTextEditingController
                                        .value.text.isNotEmpty &&
                                    addressTextEditingController
                                        .value.text.isNotEmpty),
                                onTapEvent: () {
                                  bloc.add(
                                    RegisterSubmitEvent(
                                      imagePath: imagePath,
                                      request: AddRestaurantPostRequest(
                                        name: nameTextEditingController
                                            .value.text,
                                        mobileNumber: widget.mobileNumber,
                                        emailAddress: emailTextEditingController
                                            .value.text,
                                        address: addressTextEditingController
                                            .value.text,
                                        restaurantImageURL: imagePath,
                                        status: true,
                                      ),
                                    ),
                                  );
                                },
                                followIcon: AssetImagePath.arrowRightWhiteIcon,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
