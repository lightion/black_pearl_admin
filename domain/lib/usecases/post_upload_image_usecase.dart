import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/repositories/restaurant_repository.dart';

class PostUploadImageUseCase {
  final RestaurantRepository repository;

  PostUploadImageUseCase({required this.repository});

  Future<Either<Failure, String>> call(
    List<int> image,
    int id,
  ) async {
    return await repository.uploadImage(image, id);
  }
}
