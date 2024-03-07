import 'dart:async';
import 'dart:math';

import 'package:core/enums/menu_type.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
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
    on<HomeMenuUploadMenuEvent>(_menuUpload);
  }

  FutureOr<void> _imageUpload(
      HomeMenuUploadImageEvent event, Emitter<HomeMenuState> emit) async {
    emit(HomeMenuLoading());
    String? imageUrl;
    await postUploadImageUseCase.call(event.image, event.restId).then((value) {
      if (isClosed) return;
      value.fold((failure) {
        emit(HomeMenuErrorState(error: "Api Failed"));
      }, (success) async {
        print(
            "rest id: ${event.restId}, menuType: ${event.menuType.name} url: ${success.imageUrl}");
        imageUrl = success.imageUrl;
        add(HomeMenuUploadMenuEvent(
          restId: event.restId,
          imageUrl: imageUrl ?? "",
          menuType: event.menuType,
        ));
      });
    });
  }

  FutureOr<void> _menuUpload(
      HomeMenuUploadMenuEvent event, Emitter<HomeMenuState> emit) async {
    emit(HomeMenuLoading());

    print ("rest id: ${event.restId}, menuType: ${event.menuType.name} url: ${event.imageUrl}");

    final menuResponse = await addMenuUseCase.call(
      AddMenuPostRequest(
        menuImageURL: event.imageUrl,
        menuType: event.menuType.name,
        restaurantId: event.restId,
      ),
    );
    menuResponse.fold(
      (menuFailure) => emit(HomeMenuErrorState(error: "Api Failed")),
      (menuSuccess) {
        emit(HomeMenuImageUploadSuccessState());
      },
    );
  }
}
