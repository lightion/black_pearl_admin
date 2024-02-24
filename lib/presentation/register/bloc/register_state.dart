part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterImageSelectedSuccessState extends RegisterState {
  final String path;

  RegisterImageSelectedSuccessState({required this.path});
}

class RegisterLoadingState extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterFilledState extends RegisterState {}

class RegisterSuccessfulState extends RegisterState {
  final String id;
  final String mobileNumber;

  RegisterSuccessfulState({
    required this.id,
    required this.mobileNumber,
  });
}

class RegisterFailedState extends RegisterState {
  final String error;

  RegisterFailedState({required this.error});
}
