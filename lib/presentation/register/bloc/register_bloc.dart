import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/usecases/post_add_restaurant_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final PostAddRestaurantUseCase addRestaurantUseCase;
  final PostUploadImageUseCase postUploadImageUseCase;
  final SharedPreferenceService sharedPreference;

  RegisterBloc({
    required this.addRestaurantUseCase,
    required this.postUploadImageUseCase,
    required this.sharedPreference,
  }) : super(RegisterInitialState()) {
    on<RegisterImageUploadEvent>(_onImagePicked);
    on<RegisterSubmitEvent>(_onSubmitEvent);
  }

  FutureOr<void> _onImagePicked(
      RegisterImageUploadEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(RegisterImageSelectedSuccessState(path: pickedFile.path));
    } else {
      emit(RegisterFailedState(error: "Image Upload Unsuccessful"));
    }
  }

  FutureOr<void> _onSubmitEvent(
      RegisterSubmitEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());

    String imageUrl = "";

    if (event.imagePath.isNotEmpty) {
      final imageFile = await MultipartFile.fromPath(
        'file',
        event.imagePath,
      );
      final response = await postUploadImageUseCase.call(imageFile, 0);
      if (isClosed) return;
      response.fold(
        (failure) =>
            emit(RegisterFailedState(error: "Image Upload Api Failure")),
        (success) => imageUrl = success.imageUrl ?? "",
      );
    }

    final result = await addRestaurantUseCase.call(
      AddRestaurantPostRequest(
        name: event.request.name,
        mobileNumber: event.request.mobileNumber,
        emailAddress: event.request.emailAddress,
        address: event.request.address,
        restaurantImageURL: imageUrl,
        status: event.request.status,
      ),
    );

    if (isClosed) return;
    result.fold((failure) {
      emit(RegisterFailedState(error: "Api called Failed"));
    }, (success) {
      if (success.success == true) {
        sharedPreference.writeSecureData(AppConstants.prefId, success.id ?? "");
        sharedPreference.writeSecureData(
            AppConstants.prefMobileNumber, event.request.mobileNumber ?? "");
        emit(RegisterSuccessfulState(
          id: success.id ?? "",
          mobileNumber: event.request.mobileNumber ?? "",
        ));
      } else {
        emit(RegisterFailedState(error: "Unable to register"));
      }
    });
  }
}
