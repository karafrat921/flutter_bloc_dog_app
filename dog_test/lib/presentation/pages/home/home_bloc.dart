import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/download_and_cache_images.dart';
import '../../../domain/usecases/fetch_all_dog_breeds.dart';
import '../../../domain/usecases/get_download_links_for_multiple_images.dart';
import '../../../injection.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(FetchAllDogBreedsLoadingState()) {
    on<FetchAllDogBreedsEvent>(_fetchAllDogBreeds);
  }

  Future<void> _fetchAllDogBreeds(FetchAllDogBreedsEvent event, Emitter<HomeState> emit) async {
    emit(FetchAllDogBreedsLoadingState());

    try {
      final fetchResult = await injector<FetchAllDogBreeds>().execute(const Params());
      final imageList = fetchResult.breeds.breeds.map((breed) => breed.breed).toList();

      final images = await injector<GetDownloadLinksForMultipleImages>().execute(ParamsForMultipleImage(imageList));
      final imagePaths = images.map((image) => image.message).toList();

      final downloadedImages = await injector<DownloadAndCacheImages>().execute(ParamsForImage(imagePaths));

      final breeds = List<Breed>.generate(
        downloadedImages.length,
            (i) => Breed(
          title: fetchResult.breeds.breeds[i].breed,
          path: downloadedImages[i],
          subTitle: fetchResult.breeds.breeds[i].subBreed,
        ),
      );

      emit(FetchAllDogBreedsComplatedState(
        breedsListAllEntity: fetchResult,
        breeds: breeds,
      ));
    } catch (error) {
      emit(FetchAllDogBreedsErrorState(message: error.toString()));
    }
  }
}
