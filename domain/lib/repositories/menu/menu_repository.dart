import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/menu/add_menu_entity.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';

abstract class MenuRepository {
  Future<Either<Failure, AddMenuEntity>> postAddMenu(
      AddMenuPostRequest request);

  Future<Either<Failure, GetMenuEntity>> getMenu(
    int restId,
    String menuType,
  );

  Future<Either<Failure, void>> deleteMenu(int menuId);
}
