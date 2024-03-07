import 'dart:async';
import 'dart:math';

import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'home_menu_event.dart';

part 'home_menu_state.dart';

class HomeMenuBloc extends Bloc<HomeMenuEvent, HomeMenuState> {
  final SharedPreferenceService preference;
  final PostAddMenuUseCase addMenuUseCase;
  final PostUploadImageUseCase postUploadImageUseCase;

  HomeMenuBloc({
    required this.preference,
    required this.addMenuUseCase,
    required this.postUploadImageUseCase,
  }) : super(HomeMenuInitial()) {
    on<HomeMenuLoadingEvent>((event, emit) => emit(HomeMenuLoading()));
    on<HomeMenuImagePickerClickedEvent>((event, emit) async {
      emit(HomeMenuLoading());

      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      final pickedFileBytes = await pickedFile?.readAsBytes();

      emit(HomeMenuImageSelectedSuccess(
        path: pickedFile?.path ?? "",
        pickedFileBytes: pickedFileBytes,
        pickedFile: pickedFile,
      ));
    });
    on<HomeMenuUploadImageEvent>(_imageUpload);
  }

  FutureOr<void> _imageUpload(
      HomeMenuUploadImageEvent event, Emitter<HomeMenuState> emit) async {
    emit(HomeMenuLoading());
    final result = await postUploadImageUseCase.call(event.image, event.restId);
    if (isClosed) return;
    result.fold((failure) {
      emit(HomeMenuErrorState(error: "Api Failed"));
    }, (success) {
      print(success);
      emit(HomeMenuImageUploadSuccessState());
    });
  }
}
