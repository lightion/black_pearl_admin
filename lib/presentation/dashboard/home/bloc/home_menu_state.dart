part of 'home_menu_bloc.dart';

abstract class HomeMenuState extends Equatable {}

class HomeMenuInitial extends HomeMenuState {
  @override
  List<Object?> get props => [];
}

class HomeMenuLoading extends HomeMenuState {
  @override
  List<Object?> get props => [];
}

class HomeMenuImageSelectedSuccess extends HomeMenuState {
  final XFile? pickedFile;

  final List<int>? pickedFileBytes;

  final String path;

  HomeMenuImageSelectedSuccess(
      {required this.path,
      required this.pickedFileBytes,
      required this.pickedFile});

  @override
  List<Object?> get props => [];
}

class HomeMenuErrorState extends HomeMenuState {
  final String error;

  HomeMenuErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

class HomeMenuImageUploadSuccessState extends HomeMenuState {
  @override
  List<Object?> get props => [];
}
