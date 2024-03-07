import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';
import 'package:domain/repositories/restaurant_repository.dart';

import '../entities/restaurant/update_restaurant_post_request.dart';

class PostUpdateRestaurantUseCase {
  final RestaurantRepository repository;

  PostUpdateRestaurantUseCase({required this.repository});

  Future<Either<Failure, AddRestaurantEntity>> call(
      UpdateRestaurantPostRequest request,
      ) async {
    return await repository.postUpdateRestaurant(request);
  }
}
