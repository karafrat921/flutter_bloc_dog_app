import '../../../domain/entities/breeds_list_all_entity.dart';

abstract class RandomImageState {}

class FetchRandomImageLoadingState extends RandomImageState {}

class FetchRandomImageComplatedState extends RandomImageState {
  String path;

  FetchRandomImageComplatedState({
    required this.path,
  });
}

class FetchRandomImageErrorState extends RandomImageState {
  final String message;

  FetchRandomImageErrorState({required this.message});
}
