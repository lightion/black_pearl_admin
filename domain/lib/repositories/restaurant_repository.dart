import 'package:dartz/dartz.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:core/error/failures.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants();

  Future<Either<Failure, RestaurantEntity>> getRestaurantByMobile(
    String mobileNumber,
  );

  Future<Either<Failure, AddRestaurantEntity>> postAddRestaurant(
    AddRestaurantPostRequest request,
  );

  Future<Either<Failure, String>> uploadImage(
    List<int> image,
    int id,
  );
}
