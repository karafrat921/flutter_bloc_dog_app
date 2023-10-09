import 'package:dog_test/data/datasources/local_datasource/local_datasource.dart';
import 'package:dog_test/data/models/image_model.dart';
import 'package:dog_test/domain/entities/image_entity.dart';

import '../../domain/entities/breeds_list_all_entity.dart';
import '../../domain/repositories/breeds_repository.dart';
import '../datasources/remote_datasource/remote_datasource.dart';
import '../models/breeds_list_all_model.dart';

class BreedsRepositoryImpl implements BreedsRepository {
  final LocalDataSource localDatasourceImp;
  final RemoteDataSource remoteDataSourceImp;

  const BreedsRepositoryImpl({
    required this.remoteDataSourceImp,
    required this.localDatasourceImp,
  });

  @override
  Future<BreedsListAllEntity> fetchAllDogBreeds() async {
    try {
      BreedsListAllModel breedsListAllModel = await remoteDataSourceImp.fetchAllDogBreeds();
      return breedsListAllModel.convertToEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> downloadAndCacheImages(List<String> imageUrls) async {
    return await remoteDataSourceImp.downloadAndCacheImages(imageUrls);
  }

  @override
  Future<List<ImageEntity>> getDownloadLinksForMultipleImages(List<String> keys) async {
    List<ImageEntity> images=[];
    try {
      List<ImageModel> imageModels = await remoteDataSourceImp.getDownloadLinksForMultipleImages(keys);
      for(int i=0;i<imageModels.length;i++){
        images.add(imageModels[i].convertToEntity());
      }
      return images;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ImageEntity> fetchRandomImages(String key) async {
    try {
      ImageModel imageModel = await remoteDataSourceImp.fetchRandomImages(key);
      return imageModel.convertToEntity();
    } catch (e) {
      rethrow;
    }
  }
}
