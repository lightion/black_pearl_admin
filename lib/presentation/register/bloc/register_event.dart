part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class RegisterImageUploadEvent extends RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterFilledEvent extends RegisterEvent {}

class RegisterSubmitEvent extends RegisterEvent {
  final AddRestaurantPostRequest request;

  RegisterSubmitEvent({required this.request});
}
