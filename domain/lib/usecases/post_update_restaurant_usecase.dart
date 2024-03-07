import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/repositories/restaurant_repository.dart';

class PostUpdateRestaurantUseCase {
  final RestaurantRepository repository;

  PostUpdateRestaurantUseCase({required this.repository});

  Future<Either<Failure, AddRestaurantEntity>> call(
      AddRestaurantPostRequest request,
      ) async {
    return await repository.postUpdateRestaurant(request);
  }
}
