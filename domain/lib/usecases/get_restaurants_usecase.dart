import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:domain/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantRepository repository;

  GetRestaurantsUseCase({required this.repository});

  Future<Either<Failure, List<RestaurantEntity>>> call() async {
    return await repository.getRestaurants();
  }
}
