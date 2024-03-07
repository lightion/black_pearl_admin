part of 'home_menu_bloc.dart';

abstract class HomeMenuEvent extends Equatable {}

class HomeMenuImagePickerClickedEvent extends HomeMenuEvent {
  @override
  List<Object?> get props => [];
}

class HomeMenuLoadingEvent extends HomeMenuEvent {
  @override
  List<Object?> get props => [];

}

class HomeMenuUploadImageEvent extends HomeMenuEvent {

  final int restId;

  final List<int> image;

  HomeMenuUploadImageEvent({required this.restId, required this.image});

  @override
  List<Object?> get props => [];
}
