import 'package:equatable/equatable.dart';

import '../../data/models/breeds_list_all_model.dart';

class BreedsListAllEntity extends Equatable {
  final BreedsEntity breeds;
  final String status;

  const BreedsListAllEntity({
    required this.breeds,
    required this.status,
  });

  @override
  List<Object?> get props => [breeds];
}

class BreedsEntity extends Equatable {
  final List<Breed> breeds;

  const BreedsEntity({
    required this.breeds,
  });

  @override
  List<Object?> get props => [breeds];
}
