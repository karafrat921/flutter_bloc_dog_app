import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String message;
  final String status;

  const ImageEntity({required this.message, required this.status});

  @override
  List<Object?> get props => [status, message];
}
