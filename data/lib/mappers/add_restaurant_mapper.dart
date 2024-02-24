import 'package:data/mappers/core/abstract_repository_mapper.dart';
import 'package:data/models/add_restaurant_response.dart';
import 'package:domain/entities/restaurant/add_restaurant_entity.dart';

class AddRestaurantMapper extends AbstractRepositoryMapper<AddRestaurantEntity,
    AddRestaurantResponse> {
  @override
  AddRestaurantEntity parseToView(AddRestaurantResponse model) {
    return AddRestaurantEntity(
      responseStatus: model.responseStatus,
      success: model.success,
      message: model.message,
      id: model.id,
    );
  }
}
