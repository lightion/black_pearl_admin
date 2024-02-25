import 'dart:async';

import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'home_menu_event.dart';

part 'home_menu_state.dart';

class HomeMenuBloc extends Bloc<HomeMenuEvent, HomeMenuState> {
  final SharedPreferenceService preference;
  final PostAddMenuUseCase addMenuUseCase;

  HomeMenuBloc({
    required this.preference,
    required this.addMenuUseCase,
  }) : super(HomeMenuInitial()) {
    on<HomeMenuImagePickerClickedEvent>((event, emit) async {
      emit(HomeMenuLoading());

      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      emit(HomeMenuImageSelectedSuccess(
        path: pickedFile?.path ?? "",
        pickedFile: pickedFile,
      ));
    });
    on<HomeMenuUploadImageEvent>(_imageUpload);
  }

  FutureOr<void> _imageUpload(
      HomeMenuUploadImageEvent event, Emitter<HomeMenuState> emit) async {
    emit(HomeMenuLoading());
    print(event.request.toJson());
    final result = await addMenuUseCase.call(event.request);
    if (isClosed) return;
    result.fold((failure) {
      emit(HomeMenuErrorState(error: "Api Failed"));
    }, (success) {
      emit(HomeMenuImageUploadSuccessState());
    });
  }
}
