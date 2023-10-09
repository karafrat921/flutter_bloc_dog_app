import '../entities/breeds_list_all_entity.dart';
import '../entities/image_entity.dart';

abstract class BreedsRepository {
  Future<BreedsListAllEntity> fetchAllDogBreeds();

  Future<List<String>> downloadAndCacheImages(List<String> imageUrls);

  Future<List<ImageEntity>> getDownloadLinksForMultipleImages(List<String> keys);

  Future<ImageEntity> fetchRandomImages(String key);
}
