part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeMenuClickedEvent extends HomeEvent {
  final MenuType type;

  HomeMenuClickedEvent({required this.type});
}
