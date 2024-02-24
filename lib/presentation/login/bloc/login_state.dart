part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginMobileSuccessState extends LoginState {
  final String verificationId;
  final String mobileNumber;

  LoginMobileSuccessState(
      {required this.verificationId, required this.mobileNumber});

  @override
  List<Object?> get props => [verificationId];
}

class LoginMobileFailedState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginOtpFailedState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginOtpTimedOutState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

class LoginTimedOutState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginCheckState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginRegistrationRequiredState extends LoginState {
  @override
  List<Object?> get props => [];
}
