import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';

import '../../repositories/menu/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repository;

  GetMenuUseCase({required this.repository});

  Future<Either<Failure, GetMenuEntity>> call(
      int restId, String menuType) async {
    return await repository.getMenu(restId, menuType);
  }
}
