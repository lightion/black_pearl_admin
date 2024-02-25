import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/menu/add_menu_entity.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';

abstract class MenuRepository {
  Future<Either<Failure, AddMenuEntity>> postAddMenu(
      AddMenuPostRequest request);
}
