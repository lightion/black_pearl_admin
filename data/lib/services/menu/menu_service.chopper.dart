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
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
