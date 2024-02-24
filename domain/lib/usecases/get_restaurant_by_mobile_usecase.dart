import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:domain/repositories/restaurant_repository.dart';

class GetRestaurantByMobileUseCase {
  final RestaurantRepository repository;

  GetRestaurantByMobileUseCase({required this.repository});

  Future<Either<Failure, RestaurantEntity>> call(String mobileNumber) async {
    return await repository.getRestaurantByMobile(mobileNumber);
  }
}
