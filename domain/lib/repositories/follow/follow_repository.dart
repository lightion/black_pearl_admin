import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../entities/follow/follower_entity.dart';

abstract class FollowRepository {
  Future<Either<Failure, List<FollowerEntity>>> getAllFollowers(int restId);
}
