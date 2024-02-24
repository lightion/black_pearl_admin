import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:core/enums/menu_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRestaurantByMobileUseCase mobileUseCase;
  final SharedPreferenceService preference;

  HomeBloc({
    required this.mobileUseCase,
    required this.preference,
  }) : super(HomeInitialState()) {
    on<HomeInitialEvent>(_onInitialEvent);
    on<HomeMenuClickedEvent>(
        (event, emit) => emit(HomeMenuClickedState(type: event.type)));
  }

  FutureOr<void> _onInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    final id = await preference.readSecureData(AppConstants.prefId) ?? "";
    final mobileNumber =
        await preference.readSecureData(AppConstants.prefMobileNumber) ?? "";
    if (id.isEmpty) {
      emit(HomeLoadingState());
      final result = await mobileUseCase.call(mobileNumber);

      if (isClosed) return;
      result.fold((failure) {
        emit(HomeErrorState(error: "Api Failed"));
      }, (success) {
        preference.writeSecureData(
          AppConstants.prefId,
          success.id,
        );
        emit(HomeInitialState());
      });
    }
  }
}
