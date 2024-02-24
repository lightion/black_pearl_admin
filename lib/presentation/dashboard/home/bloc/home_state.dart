part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}

class HomeMenuClickedState extends HomeState {
  final MenuType type;

  HomeMenuClickedState ({required this.type});
}