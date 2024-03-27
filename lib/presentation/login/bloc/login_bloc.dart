import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:data/repository/phone_auth_repository.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/get_restaurants_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PhoneAuthRepository phoneAuthRepository;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GetRestaurantsUseCase useCase;
  final GetRestaurantByMobileUseCase mobileUseCase;
  final SharedPreferenceService preference;

  int? resendTokenInBloc;
  String _verificationId = "";

  LoginBloc({
    required this.phoneAuthRepository,
    required this.useCase,
    required this.mobileUseCase,
    required this.preference,
  }) : super(LoginInitialState()) {
    on<LoginInitialEvent>(_onInitialize);
    on<LoginAttemptEvent>(_onSendOtp);
    on<LoginOtpEvent>(_onVerifyOtp);
    on<LoginOtpSentEvent>((event, emit) => emit(LoginMobileSuccessState(
          verificationId: event.verificationId,
          mobileNumber: event.mobileNumber,
        )));
    on<LoginErrorEvent>(
        (event, emit) => emit(LoginErrorState(error: event.error)));
    on<LoginAuthVerificationCompleteEvent>(_loginWithCredential);
    on<LoginTimedOutEvent>(_timedOut);
    on<LoginResendEvent>((event, emit) => add(LoginAttemptEvent(
          mobileNumber: event.mobileNumber,
        )));
    on<LoginCheckEvent>(_loginCheck);
    // on<LoginInitialEvent> ((event, emit) async {
    //   emit(LoginLoadingState());
    //   await useCase.call().then((value) {
    //     if (isClosed) return;
    //     value.fold((failure) {
    //       print("FailureApiCall: $failure");
    //       emit(LoginErrorState(error: "Failed Api call"));
    //     }, (success) {
    //       if (success != null ) {
    //         print("Successful Api Call: ${success.toString()}");
    //         success.forEach((element) {
    //           print(element.name);
    //         });
    //       } else {
    //         emit(LoginErrorState(error: "Unsuccessful Api call"));
    //       }
    //     });
    //   });
    // });
  }

  FutureOr<void> _onInitialize(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final id = await preference.readSecureData(AppConstants.prefId) ?? "";
    final mobileNumber =
        await preference.readSecureData(AppConstants.prefMobileNumber) ?? "";
    if (id.isNotEmpty || mobileNumber.isNotEmpty) {
      emit(LoginSuccessState());
    } else {
      emit(LoginInitialState());
    }
  }

  FutureOr<void> _onSendOtp(
    LoginAttemptEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      await phoneAuthRepository.verifyPhone(
        phoneNumber: "+91${event.mobileNumber}",
        verificationCompleted: (credential) async {
          add(LoginAuthVerificationCompleteEvent(credential: credential));
        },
        verificationFailed: (e) {
          add(LoginErrorEvent(error: e.code));
        },
        codeSent: (verificationId, int? resendToken) async {
          add(LoginOtpSentEvent(
            verificationId: verificationId,
            token: resendToken,
            mobileNumber: event.mobileNumber,
          ));
          _verificationId = verificationId;
          resendTokenInBloc = resendToken;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          verificationId = _verificationId;
        },
        resendToken: resendTokenInBloc,
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
          emit(LoginCheckState());
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

  FutureOr<void> _timedOut(LoginTimedOutEvent event, Emitter<LoginState> emit) {
    emit(LoginTimedOutState());
  }

  FutureOr<void> _loginCheck(
      LoginCheckEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    await mobileUseCase.call(event.mobileNumber).then((value) {
      if (isClosed) return;
      value.fold((failure) {
        emit(LoginErrorState(error: "Api Failed"));
      }, (success) {
        print("success calling getrestaurantbymobile api");
        if (success.status == null) {
          print("mobile doesn't exist");
          emit(LoginRegistrationRequiredState());
        } else if (success.mobileNumber != null) {
          print("mobile exist");
          preference.writeSecureData(
              AppConstants.prefMobileNumber, event.mobileNumber);
          preference.writeSecureData(AppConstants.prefId, "${success.id}");
          preference.writeSecureData(
              AppConstants.prefRestaurantName, "${success.name}");
          emit(LoginSuccessState());
        } else {
          emit(LoginRegistrationRequiredState());
        }
      });
    });
  }
}
