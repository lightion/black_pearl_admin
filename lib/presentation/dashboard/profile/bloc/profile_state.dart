part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}

class ProfileSuccessfulLogoutState extends ProfileState {}

class ProfileEditState extends ProfileState {}
