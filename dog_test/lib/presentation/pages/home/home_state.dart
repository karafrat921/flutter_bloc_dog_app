import '../../../domain/entities/breeds_list_all_entity.dart';

abstract class HomeState {}

class FetchAllDogBreedsLoadingState extends HomeState {}

class FetchAllDogBreedsComplatedState extends HomeState {
  BreedsListAllEntity breedsListAllEntity;

  //List<String> images;
  List<Breed> breeds;

  FetchAllDogBreedsComplatedState({
    required this.breedsListAllEntity,
    required this.breeds,
    //required this.images,
  });
}

class FetchAllDogBreedsErrorState extends HomeState {
  final String message;

  FetchAllDogBreedsErrorState({required this.message});
}

class Breed {
  final String title;
  final List<String> subTitle;
  final String path;

  Breed({required this.title, required this.path, required this.subTitle});
}
