import 'package:data/models/menu/delete_menu_response.dart';

import '../core/abstract_repository_mapper.dart';

class DeleteMenuMapper
    extends AbstractRepositoryMapper<void, DeleteMenuResponse> {
  @override
  void parseToView(DeleteMenuResponse model) {}
}
