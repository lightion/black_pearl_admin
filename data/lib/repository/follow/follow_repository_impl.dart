import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/datasources/follow/follow_remote_data_source.dart';
import 'package:domain/entities/follow/follower_entity.dart';
import 'package:domain/repositories/follow/follow_repository.dart';

import '../../mappers/follow/get_follower_mapper.dart';

class FollowRepositoryImpl implements FollowRepository {
  FollowerRemoteDataSource remoteDataSource;
  GetFollowerMapper followerMapper;

  FollowRepositoryImpl({
    required this.remoteDataSource,
    required this.followerMapper,
  });

  @override
  Future<Either<Failure, List<FollowerEntity>>> getAllFollowers(
      int restId) async {
    try {
      final response = await remoteDataSource.getAllFollowers(restId);
      return Right(followerMapper.parseToView(response));
    } on Exception catch (exception) {
      print("ServerFailure: ${exception.toString()}");
      return Left(ServerFailure(description: exception.toString()));
    }
  }
}
