import 'package:chopper/chopper.dart';

part 'restaurant_image_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class RestaurantImageService extends ChopperService {
  static RestaurantImageService create([ChopperClient? client]) =>
      _$RestaurantImageService(client);

  @Post(path: 'WebApi/api/restaurants/Restaurant/UploadRestaurantImage')
  @multipart
  Future<Response> uploadImage(
      @Part('restId') int id, @PartFile('file') List<int> image);
}
