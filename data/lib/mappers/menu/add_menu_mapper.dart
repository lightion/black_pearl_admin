import 'package:data/mappers/core/abstract_repository_mapper.dart';
import 'package:data/models/menu/add_menu_response.dart';
import 'package:domain/entities/menu/add_menu_entity.dart';

class AddMenuMapper
    extends AbstractRepositoryMapper<AddMenuEntity, AddMenuResponse> {
  @override
  AddMenuEntity parseToView(AddMenuResponse model) {
    return AddMenuEntity(
      responseStatus: model.responseStatus,
      success: model.success,
      message: model.message,
      id: model.id,
    );
  }
}
