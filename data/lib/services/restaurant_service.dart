import 'package:chopper/chopper.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';

part 'restaurant_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class RestaurantService extends ChopperService {
  static RestaurantService create([ChopperClient? client]) =>
      _$RestaurantService(client);

  @Get(path: 'WebApi/api/restaurants/Restaurant/GetRestaurants')
  Future<Response> getRestaurants();

  @Get(path: 'WebApi/api/restaurants/Restaurant/GetRestaurantByMobile')
  Future<Response> getRestaurantByMobile(
    @Query('mobile') String mobileNumber,
  );

  @Post(path: 'WebApi/api/restaurants/Restaurant/AddNewRestaurant')
  Future<Response> postAddRestaurant(@Body() AddRestaurantPostRequest request);
}
