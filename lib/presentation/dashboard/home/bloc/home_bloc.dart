import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_status_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:core/enums/menu_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRestaurantByMobileUseCase mobileUseCase;
  final PostUpdateRestaurantStatusUseCase statusUseCase;
  final SharedPreferenceService preference;

  HomeBloc({
    required this.mobileUseCase,
    required this.preference,
    required this.statusUseCase,
  }) : super(HomeLoadingState()) {
    on<HomeInitialEvent>(_onInitialEvent);
    on<HomeMenuClickedEvent>(
        (event, emit) => emit(HomeMenuClickedState(type: event.type)));
    on<HomeToggleClickedEvent>(_onToggleClickedEvent);
  }

  FutureOr<void> _onInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    final id = await preference.readSecureData(AppConstants.prefId) ?? "";
    final mobileNumber =
        await preference.readSecureData(AppConstants.prefMobileNumber) ?? "";

    emit(HomeLoadingState());
    final result = await mobileUseCase.call(mobileNumber);

    if (isClosed) return;
    await result.fold((failure) async {
      emit(HomeErrorState(error: "Api Failed"));
    }, (success) async {
      // preference.writeSecureData(
      //   AppConstants.prefId,
      //   success.id,
      // );
      await Future.delayed(const Duration(milliseconds: 500), () {
        emit(HomeInitialState(status: success.status ?? false));
      });
    });
  }

  FutureOr<void> _onToggleClickedEvent(
    HomeToggleClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    final id = await preference.readSecureData(AppConstants.prefId) ?? "";

    final response = await statusUseCase.call(
        id.isNotEmpty ? int.parse(id) : 1002, event.updateStatus);
    if (isClosed) return;
    response.fold(
      (failure) => emit(HomeErrorState(error: "Toggle Api Failed")),
      (success) {
        add(HomeInitialEvent());
      },
    );
  }
}
