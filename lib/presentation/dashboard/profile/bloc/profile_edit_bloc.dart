import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:domain/entities/restaurant/update_restaurant_post_request.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:domain/usecases/post_upload_restaurant_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_edit_event.dart';

part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final GetRestaurantByMobileUseCase mobileUseCase;

  final SharedPreferenceService preference;

  final PostUploadRestaurantImageUseCase postUploadImageUseCase;

  final PostUpdateRestaurantUseCase updateRestaurantUseCase;

  ProfileEditBloc(
      {required this.mobileUseCase,
      required this.preference,
      required this.postUploadImageUseCase,
      required this.updateRestaurantUseCase})
      : super(ProfileEditLoadingState()) {
    on<ProfileEditInitialEvent>(_onInitialise);
    on<ProfileEditImageUploadEvent>(_onUploadImageEvent);
    on<ProfileEditUpdateEvent>(_updateRestaurant);
  }

  FutureOr<void> _onInitialise(
      ProfileEditInitialEvent event, Emitter<ProfileEditState> emit) async {
    emit(ProfileEditLoadingState());
    String mobileNumber =
        await preference.readSecureData(AppConstants.prefMobileNumber) ?? "";
    final response = await mobileUseCase.call(mobileNumber);
    if (isClosed) return;
    response.fold(
      (failure) => emit(ProfileEditErrorState(error: "Api Failed")),
      (success) => emit(ProfileEditInitialSuccessState(restaurant: success)),
    );
  }

  FutureOr<void> _onUploadImageEvent(
    ProfileEditImageUploadEvent event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(ProfileEditLoadingState());
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(ProfileEditImageSelectedSuccessState(path: pickedFile.path));
    } else {
      emit(ProfileEditErrorState(error: "Image Upload Unsuccessful"));
    }
  }

  FutureOr<void> _updateRestaurant(
    ProfileEditUpdateEvent event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(ProfileEditLoadingState());
    final restId = await preference.readSecureData(AppConstants.prefId) ?? "";
    String restImagePath = event.request.restaurantImageURL ?? "";
    if (event.imagePath.isNotEmpty) {
      final imageFile = await MultipartFile.fromPath(
        'file',
        event.imagePath,
      );
      final response = await postUploadImageUseCase.call(
        imageFile,
      );
      if (isClosed) return;
      response.fold(
        (failure) =>
            emit(ProfileEditErrorState(error: "Image Upload Api Failure")),
        (success) => restImagePath = success.imageUrl ?? "",
      );
    }

    final response =
        await updateRestaurantUseCase.call(UpdateRestaurantPostRequest(
      id: restId.isNotEmpty ? int.parse(restId) : 1002,
      name: event.request.name,
      mobileNumber: event.request.mobileNumber,
      emailAddress: event.request.emailAddress,
      address: event.request.address,
      restaurantImageURL: restImagePath,
      status: true,
    ));

    response.fold(
      (failure) => emit(ProfileEditErrorState(error: "Api Failed")),
      (success) => emit(ProfileEditUpdateSuccessState()),
    );
  }
}
