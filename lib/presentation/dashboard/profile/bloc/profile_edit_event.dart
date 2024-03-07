part of 'profile_edit_bloc.dart';

abstract class ProfileEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEditInitialEvent extends ProfileEditEvent {}

class ProfileEditImageUploadEvent extends ProfileEditEvent {}

class ProfileEditUpdateEvent extends ProfileEditEvent {
  final UpdateRestaurantPostRequest request;
  final String imagePath;
  ProfileEditUpdateEvent ({required this.request, required this.imagePath});
}
