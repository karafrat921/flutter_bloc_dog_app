import '../../domain/entities/breeds_list_all_entity.dart';

class BreedsListAllModel {
  final BreedsModel breedsModel;
  final String status;

  BreedsListAllModel({
    required this.breedsModel,
    required this.status,
  });

  factory BreedsListAllModel.fromJson(Map<String, dynamic> json) => BreedsListAllModel(
        breedsModel: BreedsModel.fromJson(json["message"]),
        status: json["status"],
      );

  BreedsListAllEntity convertToEntity() {
    return BreedsListAllEntity(breeds: breedsModel, status: status);
  }
}

class BreedsModel extends BreedsEntity {
  List<Breed> breeds;

  BreedsModel({required this.breeds}) : super(breeds: breeds);

  factory BreedsModel.fromJson(Map<String, dynamic> json) {
    List<Breed> parseBreedsFromJson(Map<String, dynamic> json) {
      List<Breed> breeds = [];
      json.forEach((breedJ, subBreedJ) {
        breeds.add(
          Breed(
            breed: breedJ,
            subBreed: subBreedJ.cast<String>(),
          ),
        );
      });

      return breeds;
    }

    return BreedsModel(
      breeds: parseBreedsFromJson(json),
    );
  }
}

class Breed {
  final String breed;
  final List<String> subBreed;

  Breed({required this.breed, required this.subBreed});
}
