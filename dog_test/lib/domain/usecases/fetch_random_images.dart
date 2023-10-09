import 'package:dog_test/domain/entities/image_entity.dart';
import 'package:dog_test/domain/repositories/breeds_repository.dart';
import '../../core/usecase/base_usecase.dart';

class ParamsForRandomImages {
  String key;
   ParamsForRandomImages({required this.key});
}

class FetchRandomImages extends BaseUseCase<Future<ImageEntity>, ParamsForRandomImages> {
  final BreedsRepository breedsRepository;

  const FetchRandomImages(this.breedsRepository);

  @override
  Future<ImageEntity> execute(ParamsForRandomImages params) async {
    return await breedsRepository.fetchRandomImages(params.key);
  }
}
