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

  final MultipartFile image;

  final MenuType menuType;

  HomeMenuUploadImageEvent(
      {required this.restId, required this.image, required this.menuType});

  @override
  List<Object?> get props => [];
}

class HomeMenuUploadMenuEvent extends HomeMenuEvent {
  final int restId;
  final String imageUrl;
  final MenuType menuType;

  HomeMenuUploadMenuEvent({
    required this.restId,
    required this.imageUrl,
    required this.menuType,
  });

  @override
  List<Object?> get props => [];
}
