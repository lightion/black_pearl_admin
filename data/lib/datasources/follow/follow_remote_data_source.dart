import 'package:data/models/follow/get_all_follow_response.dart';
import 'package:data/services/follow/follow_service.dart';

abstract class FollowerRemoteDataSource {
  Future<GetAllFollowResponse> getAllFollowers(
    int restId,
  );
}

class FollowerRemoteDataSourceImpl implements FollowerRemoteDataSource {
  final FollowService followService;

  FollowerRemoteDataSourceImpl({required this.followService});

  @override
  Future<GetAllFollowResponse> getAllFollowers(int restId) async {
    final response = await followService.getAllFollowers(restId);
    if (response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return GetAllFollowResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }
}
