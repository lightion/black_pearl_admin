part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListInitialEvent extends ListEvent {}

class ListDeleteEvent extends ListEvent {
  final int menuId;

  ListDeleteEvent({required this.menuId});
}
