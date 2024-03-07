import 'package:chopper/chopper.dart';
import 'package:data/models/image/add_image_response.dart';
import 'package:data/services/restaurant_service.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:http/http.dart' as http;

import '../models/add_restaurant_response.dart';
import '../models/mobile_restaurant_response.dart';
import '../models/restaurant_response.dart';
import '../services/restaurant_image_service.dart';

abstract class RestaurantRemoteDataSource {
  Future<RestaurantResponse> getRestaurants();

  Future<MobileRestaurantResponse> getRestaurantByMobile(String mobileNumber);

  Future<AddRestaurantResponse> postAddRestaurant(
      AddRestaurantPostRequest request);

  Future<AddRestaurantResponse> postUpdateRestaurant(
      AddRestaurantPostRequest request);

  Future<AddImageResponse> uploadImage(http.MultipartFile image, int id);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  RestaurantService restaurantService;
  RestaurantImageService restaurantImageService;

  RestaurantRemoteDataSourceImpl({
    required this.restaurantService,
    required this.restaurantImageService,
  });

  @override
  Future<RestaurantResponse> getRestaurants() async {
    Response? response = await restaurantService.getRestaurants();

    if (response != null &&
        response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return RestaurantResponse.fromJson(response.body);
    } else {
      if (response == null) {
        throw Exception("Response is null");
      }
      if (!response.isSuccessful) {
        throw Exception(
            "Response is Unsuccessful status code: ${response.statusCode}");
      }
      if (response.body == null) {
        throw Exception("Response Body is null");
      }
      if (response.statusCode != 200) {
        throw Exception("Response Code is: ${response.statusCode}");
      }
      throw Exception();
    }
  }

  @override
  Future<MobileRestaurantResponse> getRestaurantByMobile(
      String mobileNumber) async {
    Response? response =
        await restaurantService.getRestaurantByMobile(mobileNumber);

    if (response != null &&
        response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return MobileRestaurantResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }

  @override
  Future<AddRestaurantResponse> postAddRestaurant(
      AddRestaurantPostRequest request) async {
    final response = await restaurantService.postAddRestaurant(request);
    if (response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return AddRestaurantResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }

  @override
  Future<AddImageResponse> uploadImage(http.MultipartFile image, int id) async {
    final response = await restaurantImageService.uploadImage(image);
    if (response.isSuccessful && response.statusCode == 200) {
      return AddImageResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }

  @override
  Future<AddRestaurantResponse> postUpdateRestaurant(
      AddRestaurantPostRequest request) async {
    final response = await restaurantService.postUpdateRestaurant(request);
    if (response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return AddRestaurantResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }
}
