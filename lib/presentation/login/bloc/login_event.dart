part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginAttemptEvent extends LoginEvent {
  final String mobileNumber;

  LoginAttemptEvent({required this.mobileNumber});

  @override
  List<Object?> get props => [mobileNumber];
}

class LoginOtpEvent extends LoginEvent {
  final String otpCode;
  final String verificationId;

  LoginOtpEvent({
    required this.otpCode,
    required this.verificationId,
  });

  @override
  List<Object?> get props => [otpCode, verificationId];
}

class LoginOtpSentEvent extends LoginEvent {
  final String verificationId;
  final int? token;
  final String mobileNumber;

  LoginOtpSentEvent(
      {required this.verificationId,
      required this.token,
      required this.mobileNumber});

  @override
  List<Object?> get props => [verificationId];
}

class LoginRetryEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginAuthVerificationCompleteEvent extends LoginEvent {
  final AuthCredential credential;

  LoginAuthVerificationCompleteEvent({required this.credential});

  @override
  List<Object?> get props => [];
}

class LoginSuccessEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginErrorEvent extends LoginEvent {
  final String error;

  LoginErrorEvent({required this.error});

  @override
  List<Object?> get props => [];
}

class LoginTimedOutEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginResendEvent extends LoginEvent {
  final String mobileNumber;

  LoginResendEvent({required this.mobileNumber});

  @override
  List<Object?> get props => [];
}

class LoginCheckEvent extends LoginEvent {
  final String mobileNumber;

  LoginCheckEvent({required this.mobileNumber});

  @override
  List<Object?> get props => [];
}
