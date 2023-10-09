import '../../models/breeds_list_all_model.dart';
import '../../models/image_model.dart';

abstract class RemoteDataSource {
  Future<BreedsListAllModel> fetchAllDogBreeds();

  Future<List<String>> downloadAndCacheImages(List<String> imageUrls);

  Future<List<ImageModel>> getDownloadLinksForMultipleImages(List<String> keys);

  Future<ImageModel> fetchRandomImages(String key);
}
