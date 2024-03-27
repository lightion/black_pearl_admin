import 'package:chopper/chopper.dart';

part 'follow_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class FollowService extends ChopperService {
  static FollowService create([ChopperClient? client]) =>
      _$FollowService(client);

  @Get(path: 'WebApi/api/UserFollowed/GetAllFollowedRestaurantByRestaurantId')
  Future<Response> getAllFollowers(
    @Query('restaurantId') int restId,
  );
}
