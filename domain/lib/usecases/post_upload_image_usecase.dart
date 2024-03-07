import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/image/add_image_entity.dart';
import 'package:domain/repositories/restaurant_repository.dart';
import 'package:http/http.dart';

class PostUploadImageUseCase {
  final RestaurantRepository repository;

  PostUploadImageUseCase({required this.repository});

  Future<Either<Failure, AddImageEntity>> call(
    MultipartFile image,
    int id,
  ) async {
    return await repository.uploadImage(image, id);
  }
}
