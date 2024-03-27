import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/follow/follower_entity.dart';
import 'package:domain/repositories/follow/follow_repository.dart';

class GetFollowerUseCase {
  final FollowRepository repository;

  GetFollowerUseCase({required this.repository});

  Future<Either<Failure, List<FollowerEntity>>> call(
      int restId,) async {
    return await repository.getAllFollowers(
      restId,
    );
  }
}
