import 'package:chopper/chopper.dart';
import 'package:domain/entities/restaurant/add_restaurant_post_request.dart';
import 'package:domain/entities/restaurant/update_restaurant_post_request.dart';

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

  @Post(path: 'WebApi/api/restaurants/Restaurant/UpdateRestaurant')
  Future<Response> postUpdateRestaurant(
      @Body() UpdateRestaurantPostRequest request);

  @Post(path: 'WebApi/api/restaurants/Restaurant/UpdateRestaurantStatus')
  Future<Response> postUpdateRestaurantStatus(
    @Query('id') int restId,
    @Query('newStatus') bool status,
  );
}
