part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListLoadingState extends ListState {}

class ListErrorState extends ListState {
  final String error;

  ListErrorState({
    required this.error,
  });
}

class ListLunchSuccessState extends ListState {
  final GetMenuEntity menu;

  ListLunchSuccessState({required this.menu});
}

class ListDinnerSuccessState extends ListState {
  final GetMenuEntity menu;

  ListDinnerSuccessState({required this.menu});
}

class ListLunchFailedState extends ListState {}

class ListDinnerFailedState extends ListState {}

class ListDeleteSuccessState extends ListState {}
