part of 'profile_edit_bloc.dart';

abstract class ProfileEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileEditLoadingState extends ProfileEditState {}

class ProfileEditInitialSuccessState extends ProfileEditState {
  final RestaurantEntity restaurant;

  ProfileEditInitialSuccessState({required this.restaurant});
}

class ProfileEditErrorState extends ProfileEditState {
  final String error;

  ProfileEditErrorState({required this.error});
}

class ProfileEditUpdateSuccessState extends ProfileEditState {}

class ProfileEditImageSelectedSuccessState extends ProfileEditState {
  final String path;

  ProfileEditImageSelectedSuccessState({required this.path});
}
