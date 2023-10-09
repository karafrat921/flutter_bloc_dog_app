import 'package:dog_test/domain/entities/image_entity.dart';

import '../../core/usecase/base_usecase.dart';
import '../repositories/breeds_repository.dart';

class ParamsForMultipleImage {
  final List<String> key;
  const ParamsForMultipleImage(this.key);
}

class GetDownloadLinksForMultipleImages extends BaseUseCase<Future<List<ImageEntity>>, ParamsForMultipleImage> {
  final BreedsRepository breedsRepository;

  const GetDownloadLinksForMultipleImages(this.breedsRepository);

  @override
  Future<List<ImageEntity>> execute(ParamsForMultipleImage params) async {
    return await breedsRepository.getDownloadLinksForMultipleImages(params.key);
  }
}
