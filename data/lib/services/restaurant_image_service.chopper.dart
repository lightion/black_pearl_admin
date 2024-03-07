// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_image_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$RestaurantImageService extends RestaurantImageService {
  _$RestaurantImageService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = RestaurantImageService;

  @override
  Future<Response<dynamic>> uploadImage(
    int id,
    List<int> image,
  ) {
    final Uri $url =
        Uri.parse('/WebApi/api/restaurants/Restaurant/UploadRestaurantImage');
    final List<PartValue> $parts = <PartValue>[
      PartValue<int>(
        'restId',
        id,
      ),
      PartValueFile<List<int>>(
        'file',
        image,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
