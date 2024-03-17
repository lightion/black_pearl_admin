import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

part 'restaurant_image_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class RestaurantImageService extends ChopperService {
  static RestaurantImageService create([ChopperClient? client]) =>
      _$RestaurantImageService(client);

  @Post(
      path: 'WebApi/api/restaurants/RestaurantMenu/UploadMenuImage',
      headers: {'Content-Type': 'multipart/form-data'})
  @multipart
  Future<Response> uploadImage(@PartFile('file') http.MultipartFile image);

  @Post(
      path: 'WebApi/api/restaurants/Restaurant/UploadRestaurantImage',
      headers: {'Content-Type': 'multipart/form-data'})
  @multipart
  Future<Response> uploadRestaurantImage(
      @PartFile('file') http.MultipartFile image);
}
