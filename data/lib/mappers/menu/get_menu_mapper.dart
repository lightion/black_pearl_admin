import 'package:data/models/menu/get_menu_response.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';

import '../core/abstract_repository_mapper.dart';

class GetMenuMapper
    extends AbstractRepositoryMapper<GetMenuEntity, GetMenuResponse> {
  @override
  GetMenuEntity parseToView(GetMenuResponse model) {
    return GetMenuEntity(
      id: model.responseData?.id,
      menuImageURL: model.responseData?.menuImageURL,
    );
  }
}
