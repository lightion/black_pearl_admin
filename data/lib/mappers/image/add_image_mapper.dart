import 'package:data/models/image/add_image_response.dart';
import 'package:domain/entities/image/add_image_entity.dart';

import '../core/abstract_repository_mapper.dart';

class AddImageMapper
    extends AbstractRepositoryMapper<AddImageEntity, AddImageResponse> {
  @override
  AddImageEntity parseToView(AddImageResponse model) {
    return AddImageEntity(
      imageUrl: model.responseData,
    );
  }
}
