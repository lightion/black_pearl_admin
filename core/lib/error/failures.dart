import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String? errorCode;
  final String? description;

  ServerFailure({
    this.errorCode,
    this.description,
  });
}
