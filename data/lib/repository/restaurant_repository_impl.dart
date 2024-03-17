import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/datasources/restaurant_remote_data_source.dart';
import 'package:data/mappers/restaurants_mapper.dart';
import 'package:domain/entities/image/add_image_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';
import 'package:domain/entities/restaurant/update_restaurant_post_request.dart';
import 'package:domain/repositories/restaurant_repository.dart';
import 'package:http/http.dart' as http;

import '../mappers/add_restaurant_mapper.dart';
import '../mappers/image/add_image_mapper.dart';
import '../mappers/restaurant_mapper.dart';
import '../mappers/update_restaurant_status_mapper.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  RestaurantRemoteDataSource remoteDataSource;
  RestaurantsMapper mapper;
  RestaurantMapper restaurantMapper;
  AddRestaurantMapper addRestaurantMapper;
  AddImageMapper addImageMapper;
  UpdateRestaurantStatusMapper statusMapper;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.mapper,
    required this.restaurantMapper,
    required this.addRestaurantMapper,
    required this.addImageMapper,
    required this.statusMapper,
  });

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants() async {
    try {
      final response = await remoteDataSource.getRestaurants();
      return Right(mapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantByMobile(
      String mobileNumber) async {
    try {
      final response =
          await remoteDataSource.getRestaurantByMobile(mobileNumber);
      return Right(restaurantMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, AddRestaurantEntity>> postAddRestaurant(
      AddRestaurantPostRequest request) async {
    try {
      final response = await remoteDataSource.postAddRestaurant(request);
      return Right(addRestaurantMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, AddImageEntity>> uploadImage(
      http.MultipartFile image, int id) async {
    try {
      final response = await remoteDataSource.uploadImage(image, id);
      return Right(addImageMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, AddRestaurantEntity>> postUpdateRestaurant(
      UpdateRestaurantPostRequest request) async {
    try {
      final response = await remoteDataSource.postUpdateRestaurant(request);
      return Right(addRestaurantMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postUpdateRestaurantStatus(
      int restId, bool status) async {
    try {
      final response =
          await remoteDataSource.postUpdateRestaurantStatus(restId, status);
      return Right(statusMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, AddImageEntity>> uploadRestaurantImage(
      http.MultipartFile image) async {
    try {
      final response = await remoteDataSource.uploadRestaurantImage(image);
      return Right(addImageMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }
}
