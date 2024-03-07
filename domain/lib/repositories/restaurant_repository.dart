import 'package:dartz/dartz.dart';
import 'package:domain/entities/image/add_image_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:core/error/failures.dart';
import 'package:http/http.dart' as http;

import '../entities/restaurant/update_restaurant_post_request.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants();

  Future<Either<Failure, RestaurantEntity>> getRestaurantByMobile(
    String mobileNumber,
  );

  Future<Either<Failure, AddRestaurantEntity>> postAddRestaurant(
    AddRestaurantPostRequest request,
  );

  Future<Either<Failure, AddRestaurantEntity>> postUpdateRestaurant(
    UpdateRestaurantPostRequest request,
  );

  Future<Either<Failure, void>> postUpdateRestaurantStatus(
    int restId,
    bool status,
  );

  Future<Either<Failure, AddImageEntity>> uploadImage(
    http.MultipartFile image,
    int id,
  );
}
