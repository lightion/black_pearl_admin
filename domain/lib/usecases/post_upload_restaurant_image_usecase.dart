import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../entities/image/add_image_entity.dart';
import '../repositories/restaurant_repository.dart';

class PostUploadRestaurantImageUseCase {
  final RestaurantRepository repository;

  PostUploadRestaurantImageUseCase({required this.repository});

  Future<Either<Failure, AddImageEntity>> call(
    MultipartFile image,
  ) async {
    return await repository.uploadRestaurantImage(image);
  }
}
