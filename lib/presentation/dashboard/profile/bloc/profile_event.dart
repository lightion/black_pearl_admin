part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileEditClickedEvent extends ProfileEvent {}

class ProfileLogoutClickedEvent extends ProfileEvent {}
