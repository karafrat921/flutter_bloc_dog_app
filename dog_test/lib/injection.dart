import 'package:dog_test/data/repositories/breeds_repository_impl.dart';
import 'package:dog_test/domain/repositories/breeds_repository.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/api_helper/api_base_helper.dart';
import 'data/datasources/local_datasource/local_datasource.dart';
import 'data/datasources/local_datasource/local_datasource_imp.dart';
import 'data/datasources/remote_datasource/remote_datasource.dart';
import 'data/datasources/remote_datasource/remote_datasource_imp.dart';
import 'domain/usecases/download_and_cache_images.dart';
import 'domain/usecases/fetch_all_dog_breeds.dart';
import 'domain/usecases/fetch_random_images.dart';
import 'domain/usecases/get_download_links_for_multiple_images.dart';

GetIt injector = GetIt.instance;

reset() {
  injector.reset();
}

void initializeDependencies() async {
  // http client
  injector.registerLazySingleton<http.Client>(() => http.Client());


  injector.registerLazySingleton<DefaultCacheManager>(() => DefaultCacheManager());

  //Api helper
  injector.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper(client: injector()));

  //Api
  injector.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(apiBaseHelper: injector(),defaultCacheManager: injector()));

  //local
  injector.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImp());

  //Repository
  injector.registerLazySingleton<BreedsRepository>(
    () => BreedsRepositoryImpl(
      localDatasourceImp: injector(),
      remoteDataSourceImp: injector(),
    ),
  );

  //Usecases
  injector.registerLazySingleton<FetchAllDogBreeds>(() => FetchAllDogBreeds(injector()));
  injector.registerLazySingleton<DownloadAndCacheImages>(() => DownloadAndCacheImages(injector()));
  injector.registerLazySingleton<GetDownloadLinksForMultipleImages>(() => GetDownloadLinksForMultipleImages(injector()));
  injector.registerLazySingleton<FetchRandomImages>(() => FetchRandomImages(injector()));
}
