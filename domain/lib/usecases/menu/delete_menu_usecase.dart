import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/menu/menu_repository.dart';

class DeleteMenuUseCase {
  final MenuRepository repository;

  DeleteMenuUseCase({required this.repository});

  Future<Either<Failure, void>> call(int menuId) async {
    return await repository.deleteMenu(menuId);
  }
}
