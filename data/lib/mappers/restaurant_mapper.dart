import 'package:data/mappers/core/abstract_repository_mapper.dart';
import 'package:domain/entities/restaurant/restaurant_entity.dart';

import '../models/mobile_restaurant_response.dart';

class RestaurantMapper extends AbstractRepositoryMapper<RestaurantEntity,
    MobileRestaurantResponse> {
  @override
  RestaurantEntity parseToView(MobileRestaurantResponse model) {
    return RestaurantEntity(
      id: model.responseData?.id,
      name: model.responseData?.name,
      mobileNumber: model.responseData?.mobileNumber,
      emailAddress: model.responseData?.emailAddress,
      address: model.responseData?.address,
      restaurantImageURL: model.responseData?.restaurantImageURL,
      status: model.responseData?.status,
      restaurantMenus: model.responseData?.restaurantMenus,
    );
  }
}
