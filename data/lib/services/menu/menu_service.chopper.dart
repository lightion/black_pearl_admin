// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MenuService extends MenuService {
  _$MenuService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MenuService;

  @override
  Future<Response<dynamic>> postAddMenu(AddMenuPostRequest request) {
    final Uri $url = Uri.parse(
        '/WebApi/api/restaurants/RestaurantMenu/AddNewRestaurantMenu');
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
  Future<Response<dynamic>> getMenu(
    int restId,
    String menuType,
  ) {
    final Uri $url = Uri.parse(
        '/WebApi/api/restaurants/RestaurantMenu/GetRestaurantMenuByType');
    final Map<String, dynamic> $params = <String, dynamic>{
      'restaurantId': restId,
      'type': menuType,
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
  Future<Response<dynamic>> deleteMenu(int menuId) {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/RestaurantMenu/DeleteMenuById');
    final Map<String, dynamic> $params = <String, dynamic>{'id': menuId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
