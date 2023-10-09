abstract class RandomImagesEvent {}

class FetchRandomImageEvent extends RandomImagesEvent{
  String key;
  FetchRandomImageEvent(this.key);
}