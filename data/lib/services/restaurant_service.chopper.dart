// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$RestaurantService extends RestaurantService {
  _$RestaurantService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = RestaurantService;

  @override
  Future<Response<dynamic>> getRestaurants() {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/Restaurant/GetRestaurants');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRestaurantByMobile(String mobileNumber) {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/Restaurant/GetRestaurantByMobile');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mobile': mobileNumber
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postAddRestaurant(
      AddRestaurantPostRequest request) {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/Restaurant/AddNewRestaurant');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUpdateRestaurant(
      AddRestaurantPostRequest request) {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/Restaurant/UpdateRestaurant');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
