import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/repositories/restaurant_repository.dart';

class PostUpdateRestaurantStatusUseCase {
  final RestaurantRepository repository;

  PostUpdateRestaurantStatusUseCase({required this.repository});

  Future<Either<Failure, void>> call(
    int restId,
    bool status,
  ) async {
    return await repository.postUpdateRestaurantStatus(restId, status);
  }
}
