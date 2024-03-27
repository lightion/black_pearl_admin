import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SharedPreferenceService preference;

  ProfileBloc({
    required this.preference,
  }) : super(ProfileLoadingState()) {
    on<ProfileEditClickedEvent>((event, emit) => emit(ProfileEditState()));
    on<ProfileLogoutClickedEvent>(_logoutInitiatedEvent);
  }

  FutureOr<void> _logoutInitiatedEvent(
      ProfileLogoutClickedEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    await preference
        .writeSecureData(AppConstants.prefId, "")
        .whenComplete(() async {
      await preference
          .writeSecureData(AppConstants.prefMobileNumber, "")
          .whenComplete(() => emit(ProfileSuccessfulLogoutState()));
    });
  }
}
