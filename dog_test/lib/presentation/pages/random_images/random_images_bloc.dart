import 'dart:async';
import 'package:dog_test/presentation/pages/random_images/random_images_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/download_and_cache_images.dart';
import '../../../domain/usecases/fetch_random_images.dart';
import '../../../injection.dart';
import 'random_images_state.dart';

class RandomImagesBloc extends Bloc<RandomImagesEvent, RandomImageState> {
  RandomImagesBloc() : super(FetchRandomImageLoadingState()) {
    on<FetchRandomImageEvent>(_fetchRandomImages);
  }

  FutureOr<void> _fetchRandomImages(FetchRandomImageEvent event, Emitter<RandomImageState> emit) async {
    emit(FetchRandomImageLoadingState());

    await injector<FetchRandomImages>()
        .execute(
      ParamsForRandomImages(key: event.key),
    )
        .then((value) async {
      List<String> list = await injector<DownloadAndCacheImages>().execute(ParamsForImage([value.message]));

      emit(FetchRandomImageComplatedState(path: list.first));
    }).onError((error, stackTrace) {
      emit(FetchRandomImageErrorState(message: error.toString()));
    });
  }
}
