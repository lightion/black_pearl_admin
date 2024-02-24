import 'package:data/mappers/core/abstract_repository_mapper.dart';
import 'package:data/models/restaurant_response.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';

class RestaurantsMapper extends AbstractRepositoryMapper<List<RestaurantEntity>,
    RestaurantResponse> {
  @override
  List<RestaurantEntity> parseToView(RestaurantResponse model) {
    List<RestaurantEntity> restaurantEntityList = List.empty(growable: true);
    if (model.responseData != null) {
      model.responseData?.forEach((element) {
        restaurantEntityList.add(
          RestaurantEntity(
            id: element.id,
            name: element.name,
            mobileNumber: element.mobileNumber,
            emailAddress: element.emailAddress,
            address: element.address,
            restaurantImageURL: element.restaurantImageURL,
            status: element.status,
            restaurantMenus: element.restaurantMenus,
          ),
        );
      });
    }
    return restaurantEntityList;
  }
}
