import 'package:dog_test/domain/repositories/breeds_repository.dart';
import '../../core/usecase/base_usecase.dart';
import '../entities/breeds_list_all_entity.dart';

class Params {
  const Params();
}

class FetchAllDogBreeds extends BaseUseCase<Future<BreedsListAllEntity>, Params> {
  final BreedsRepository breedsRepository;

  const FetchAllDogBreeds(this.breedsRepository);

  @override
  Future<BreedsListAllEntity> execute(Params params) async {
    return await breedsRepository.fetchAllDogBreeds();
  }
}
