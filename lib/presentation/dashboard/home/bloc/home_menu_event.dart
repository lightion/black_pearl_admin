part of 'home_menu_bloc.dart';

abstract class HomeMenuEvent extends Equatable {}

class HomeMenuImagePickerClickedEvent extends HomeMenuEvent {
  @override
  List<Object?> get props => [];
}

class HomeMenuUploadImageEvent extends HomeMenuEvent {
  final AddMenuPostRequest request;

  HomeMenuUploadImageEvent({required this.request});

  @override
  List<Object?> get props => [];
}
