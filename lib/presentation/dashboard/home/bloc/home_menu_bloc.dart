import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'home_menu_event.dart';

part 'home_menu_state.dart';

class HomeMenuBloc extends Bloc<HomeMenuEvent, HomeMenuState> {
  HomeMenuBloc() : super(HomeMenuInitial()) {
    on<HomeMenuImagePickerClickedEvent>((event, emit) async {
      emit(HomeMenuLoading());

      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      emit(HomeMenuImageSelectedSuccess(path: pickedFile?.path ?? ""));

    });
  }
}
