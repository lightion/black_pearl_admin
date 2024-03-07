import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/datasources/menu/menu_remote_data_source.dart';
import 'package:data/mappers/menu/add_menu_mapper.dart';
import 'package:domain/entities/menu/add_menu_entity.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';
import 'package:domain/repositories/menu/menu_repository.dart';

import '../../mappers/menu/get_menu_mapper.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRemoteDataSource remoteDataSource;
  AddMenuMapper addMenuMapper;
  GetMenuMapper getMenuMapper;

  MenuRepositoryImpl({
    required this.remoteDataSource,
    required this.addMenuMapper,
    required this.getMenuMapper,
  });

  @override
  Future<Either<Failure, AddMenuEntity>> postAddMenu(
      AddMenuPostRequest request) async {
    try {
      final response = await remoteDataSource.postAddMenu(request);
      return Right(addMenuMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, GetMenuEntity>> getMenu(
      int restId, String menuType) async {
    try {
      final response = await remoteDataSource.getMenu(restId, menuType);
      return Right(getMenuMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }
}
