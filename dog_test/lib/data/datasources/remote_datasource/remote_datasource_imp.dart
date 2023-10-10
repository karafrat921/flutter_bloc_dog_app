import 'package:dog_test/core/constants/endpoints.dart';
import 'package:dog_test/data/models/breeds_list_all_model.dart';
import 'package:dog_test/data/models/image_model.dart';
import '../../../core/api_helper/api_base_helper.dart';
import '../../../core/constants/constants.dart';
import 'remote_datasource.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  RemoteDataSourceImp({required this.apiBaseHelper});

  final Map<String, String> _header = {
    'Content-Type': 'application/json',
  };

  @override
  Future<BreedsListAllModel> fetchAllDogBreeds() async {
    var queryString = Constants.baseUrl + Endpoints.breedsListAll;

    var response = await apiBaseHelper.get(url: queryString, header: _header);
    return BreedsListAllModel.fromJson(response);
  }

  @override
  Future<ImageModel> fetchRandomImages(String key) async {
    var queryString = "${Constants.baseUrl}breed/$key${Endpoints.imagesRandom}";

    var response = await apiBaseHelper.get(url: queryString, header: _header);
    return ImageModel.fromJson(response);
  }

  @override
  Future<List<ImageModel>> getDownloadLinksForMultipleImages(List<String> keys) async {
    List<Future<ImageModel>> futures = [];

    for (String key in keys) {
      var queryString = "${Constants.baseUrl}breed/$key${Endpoints.imagesRandom}";
      var response = apiBaseHelper.get(url: queryString, header: _header);
      futures.add(response.then((value) => ImageModel.fromJson(value)));
    }

    List<ImageModel> results = await Future.wait(futures);

    return results;
  }

  @override
  Future<List<String>> downloadAndCacheImages(List<String> imageLinks) async {
    const String defaultImageUrl = "https://dog.ceo/api/breed/african/images/random";

    final List<String> imagePaths = [];

    final List<Future<void>> futures = [];

    for (final imageUrl in imageLinks) {
      futures.add(apiBaseHelper.downloadImage(imageUrl, imagePaths, defaultImageUrl));
    }

    await Future.wait(futures);

    return imagePaths;
  }
}
