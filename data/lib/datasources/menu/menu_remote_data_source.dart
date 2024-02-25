import 'package:data/services/menu/menu_service.dart';
import 'package:domain/entities/menu/add_menu_post_request.dart';

import '../../models/menu/add_menu_response.dart';

abstract class MenuRemoteDataSource {
  Future<AddMenuResponse> postAddMenu(AddMenuPostRequest request);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final MenuService menuService;

  MenuRemoteDataSourceImpl({required this.menuService});

  @override
  Future<AddMenuResponse> postAddMenu(AddMenuPostRequest request) async {
    final response = await menuService.postAddMenu(request);
    if (response.isSuccessful &&
        response.body != null &&
        response.statusCode == 200) {
      return AddMenuResponse.fromJson(response.body);
    } else {
      throw Exception("Response Code is : ${response.statusCode}");
    }
  }
}
