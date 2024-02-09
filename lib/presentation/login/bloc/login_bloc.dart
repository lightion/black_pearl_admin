import 'dart:async';

import 'package:data/repository/phone_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PhoneAuthRepository phoneAuthRepository;
  final FirebaseAuth auth = FirebaseAuth.instance;

  LoginBloc({required this.phoneAuthRepository}) : super(LoginInitialState()) {
    on<LoginAttemptEvent>(_onSendOtp);
    on<LoginOtpEvent>(_onVerifyOtp);
    on<LoginOtpSentEvent>((event, emit) =>
        emit(LoginMobileSuccessState(verificationId: event.verificationId)));
    on<LoginErrorEvent>(
        (event, emit) => emit(LoginErrorState(error: event.error)));
    on<LoginAuthVerificationCompleteEvent>(_loginWithCredential);
  }

  FutureOr<void> _onSendOtp(
    LoginAttemptEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      await phoneAuthRepository.verifyPhone(
        phoneNumber: event.mobileNumber,
        verificationCompleted: (credential) async {
          add(LoginAuthVerificationCompleteEvent(credential: credential));
        },
        verificationFailed: (e) {
          add(LoginErrorEvent(error: e.code));
        },
        codeSent: (verificationId, int? resendToken) {
          add(LoginOtpSentEvent(
            verificationId: verificationId,
            token: resendToken,
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
    LoginOtpEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(LoginAuthVerificationCompleteEvent(credential: credential));
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
    LoginAuthVerificationCompleteEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await auth.signInWithCredential(event.credential).then((value) {
        if (value.user != null) {
          emit(LoginSuccessState());
        } else {
          // Register
          emit(LoginErrorState(error: "Not Registered"));
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(error: e.code));
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }
}
