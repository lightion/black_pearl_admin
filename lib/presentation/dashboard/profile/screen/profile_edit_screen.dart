import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/dashboard/profile/bloc/profile_edit_bloc.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/profile_edit_textfield_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final bloc = ProfileEditBloc(
    mobileUseCase: getIt<GetRestaurantByMobileUseCase>(),
    preference: getIt<SharedPreferenceService>(),
    postUploadImageUseCase: getIt<PostUploadImageUseCase>(),
    updateRestaurantUseCase: getIt<PostUpdateRestaurantUseCase>(),
  );

  final _loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  RestaurantEntity? restaurant;
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController mobileController = TextEditingController();

    return BlocProvider(
      create: (context) => bloc..add(ProfileEditInitialEvent()),
      child: BlocConsumer<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditLoadingState) {
            _loadingOverlay.show(context);
          } else {
            _loadingOverlay.hide();
          }
          if (state is ProfileEditErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          if (state is ProfileEditInitialSuccessState) {
            restaurant = state.restaurant;
          }
          if (state is ProfileEditImageSelectedSuccessState) {
            imagePath = state.path;
          }
          if (state is ProfileEditUpdateSuccessState) {
            restaurant = null;
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
                  restaurant = null;
                  Beamer.of(context).beamBack();
                },
              ),
              backgroundColor: Colors.white,
              hideAppBar: false,
              actionList: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    height: 35.0,
                    width: 120.0,
                    child: ButtonWidget(
                      buttonText: "UPDATE",
                      isEnabled: true,
                      onTapEvent: () async {
                        bloc.add(ProfileEditUpdateEvent(
                            request: AddRestaurantPostRequest(
                              name: nameController.value.text,
                              mobileNumber: mobileController.value.text,
                              emailAddress: emailController.value.text,
                              address: addressController.value.text,
                              restaurantImageURL:
                                  restaurant?.restaurantImageURL,
                            ),
                            imagePath: imagePath));
                      },
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: ColorConstants.antiFlashWhite,
            body: restaurant != null
                ? SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                bloc.add(ProfileEditImageUploadEvent());
                              },
                              child: CircleAvatar(
                                radius: AppConstants.loginLogoRadius,
                                backgroundImage: imagePath.isNotEmpty
                                    ? FileImage(File(imagePath))
                                    : FadeInImage(
                                        image: NetworkImage(
                                            restaurant?.restaurantImageURL ??
                                                ""),
                                        placeholder: NetworkImage(
                                            'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                              'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg');
                                        },
                                      ).image,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              ProfileEditTextFieldWidget(
                                textEditingController: nameController,
                                prefixIcon: const Icon(Icons.person),
                                value: restaurant?.name ?? "",
                                labelText: "Restaurant Name",
                              ),
                              ProfileEditTextFieldWidget(
                                textEditingController: emailController,
                                prefixIcon: const Icon(Icons.email),
                                value: restaurant?.emailAddress ?? "",
                                labelText: "email",
                              ),
                              ProfileEditTextFieldWidget(
                                textEditingController: addressController,
                                prefixIcon:
                                    const Icon(Icons.location_city_sharp),
                                value: restaurant?.address ?? "",
                                labelText: "Address",
                              ),
                              ProfileEditTextFieldWidget(
                                textEditingController: mobileController,
                                prefixIcon: const Icon(Icons.phone),
                                value: restaurant?.mobileNumber ?? "",
                                labelText: "Mobile",
                                isEnabled: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
