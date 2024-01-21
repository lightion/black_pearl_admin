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
  final String path;

  HomeMenuImageSelectedSuccess({required this.path});

  @override
  List<Object?> get props => [];
}
