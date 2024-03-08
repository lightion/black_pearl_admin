import 'package:chopper/chopper.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';

part 'menu_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class MenuService extends ChopperService {
  static MenuService create([ChopperClient? client]) => _$MenuService(client);

  @Post(path: 'WebApi/api/restaurants/RestaurantMenu/AddNewRestaurantMenu')
  Future<Response> postAddMenu(@Body() AddMenuPostRequest request);

  @Get(path: 'WebApi/api/restaurants/RestaurantMenu/GetRestaurantMenuByType')
  Future<Response> getMenu(
    @Query('restaurantId') int restId,
    @Query('type') String menuType,
  );

  @Delete(path: 'WebApi/api/restaurants/RestaurantMenu/DeleteMenuById')
  Future<Response> deleteMenu(
    @Query('id') int menuId,
  );
}
