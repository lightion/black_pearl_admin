// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FollowService extends FollowService {
  _$FollowService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FollowService;

  @override
  Future<Response<dynamic>> getAllFollowers(int restId) {
    final Uri $url = Uri.parse(
        '/WebApi/api/UserFollowed/GetAllFollowedRestaurantByRestaurantId');
    final Map<String, dynamic> $params = <String, dynamic>{
      'restaurantId': restId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
