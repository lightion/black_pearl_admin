import 'dart:async';

import 'package:core/constants/app_constants.dart';
import 'package:core/enums/menu_type.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';
import 'package:domain/usecases/menu/delete_menu_usecase.dart';
import 'package:domain/usecases/menu/get_menu_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  GetMenuUseCase getMenuUseCase;
  DeleteMenuUseCase deleteMenuUseCase;
  SharedPreferenceService preference;

  ListBloc({
    required this.getMenuUseCase,
    required this.preference,
    required this.deleteMenuUseCase,
  }) : super(ListLoadingState()) {
    on<ListInitialEvent>(_onInitialise);
    on<ListDeleteEvent>(_onDelete);
  }

  FutureOr<void> _onInitialise(
    ListInitialEvent event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoadingState());
    //Checking for lunch
    final restId = await preference.readSecureData(AppConstants.prefId) ?? "";
    print("rest id: $restId");
    final responseLunch = await getMenuUseCase.call(
      restId.isNotEmpty ? int.parse(restId) : 1002,
      MenuType.lunch.name,
    );

    responseLunch.fold(
      (failure) => emit(ListErrorState(error: "Api Failed")),
      (success) {
        print("Successful call of lunch api");
        if (success.menuImageURL != null) {
          emit(ListLunchSuccessState(menu: success));
        } else {
          emit(ListLunchFailedState());
        }
      },
    );

    final responseDinner = await getMenuUseCase.call(
      restId.isNotEmpty ? int.parse(restId) : 1002,
      MenuType.dinner.name,
    );

    responseDinner.fold(
      (failure) => emit(ListErrorState(error: "Api Failed")),
      (success) {
        if (success.menuImageURL != null) {
          emit(ListDinnerSuccessState(menu: success));
        } else {
          emit(ListDinnerFailedState());
        }
      },
    );
  }

  FutureOr<void> _onDelete(
    ListDeleteEvent event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoadingState());
    final response = await deleteMenuUseCase.call(event.menuId);
    if (isClosed) return;
    response.fold(
      (failure) => emit(ListErrorState(error: "Delete Api Failed")),
      (success) => add(ListInitialEvent()),
    );
  }
}
