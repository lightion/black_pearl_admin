import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/menu/add_menu_entity.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/repositories/menu/menu_repository.dart';

class PostAddMenuUseCase {
  final MenuRepository repository;

  PostAddMenuUseCase({required this.repository});

  Future<Either<Failure, AddMenuEntity>> call(
    AddMenuPostRequest request,
  ) async {
    return await repository.postAddMenu(request);
  }
}
