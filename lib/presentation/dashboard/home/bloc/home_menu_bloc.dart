import 'dart:async';
import 'dart:convert';

import 'package:core/enums/menu_type.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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

    print(
        "rest id: ${event.restId}, menuType: ${event.menuType.name} url: ${event.imageUrl}");

    final menuResponse = await addMenuUseCase.call(
      AddMenuPostRequest(
        menuImageURL: event.imageUrl,
        menuType: event.menuType.name,
        restaurantId: event.restId,
      ),
    );
    await menuResponse.fold(
      (menuFailure) async { emit(HomeMenuErrorState(error: "Api Failed")); },
      (menuSuccess) async {
        await sendPushMessage(
          "eIFad23vTLuzaFlZn2zb89:APA91bHcQkC_JgNWBDrc9eZono4hPj7VNjXGLjKgN1g0gWkUhaQV-p51kOmhrPa8_OCgpEtYHeysygnBfkpfiYeUiQgBQqiD_uUsTEnET_bWmd7CDUZS_WBHrq9aEH0JqCAH__arveM9",
          "Teal Restaurant",
          "New Menu Uploaded",
        ).whenComplete(() => emit(HomeMenuImageUploadSuccessState()));
      },
    );
  }

  Future<void> sendPushMessage(
    String targetToken,
    String title,
    String body,
  ) async {
    const String serverKey =
        'AAAAbILzho8:APA91bH9y7YEn91KFX_lLMiroy4W5FROL7qJz2F_EPJYvodUMKOjMnwE3b13BV2_cWjn0m0amFT86syMRiVI4lR1jMxelkn1JborPKuJxVnc8TxdtBZh2AhArsXNfW3WL5FDw36i1CRo';
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    try {
      await http.post(
        Uri.parse(fcmUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': targetToken,
          },
        ),
      );
    } catch (e) {
      print("Error sending FCM message: $e");
    }
  }
}
