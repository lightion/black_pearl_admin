import 'package:data/mappers/core/abstract_repository_mapper.dart';
import 'package:data/models/follow/get_all_follow_response.dart';
import 'package:domain/entities/follow/follower_entity.dart';

class GetFollowerMapper extends AbstractRepositoryMapper<List<FollowerEntity>,
    GetAllFollowResponse> {
  @override
  List<FollowerEntity> parseToView(GetAllFollowResponse model) {
    List<FollowerEntity> followersList = List.empty(growable: true);
    if (model.responseData != null) {
      model.responseData?.forEach((element) {
        followersList.add(
          FollowerEntity(
            userId: element.userId,
            fCMToken: element.fCMToken,
            userMobileNumber: element.userMobileNumber,
          ),
        );
      });
    }
    return followersList;
  }
}
