import '../../core/usecase/base_usecase.dart';
import '../repositories/breeds_repository.dart';

class ParamsForImage {
  final List<String> list;
  const ParamsForImage(this.list);
}

class DownloadAndCacheImages extends BaseUseCase< Future<List<String>>, ParamsForImage> {
  final BreedsRepository breedsRepository;

  const DownloadAndCacheImages(this.breedsRepository);

  @override
  Future<List<String>> execute(ParamsForImage params) async {
    return await breedsRepository.downloadAndCacheImages(params.list);
  }
}
