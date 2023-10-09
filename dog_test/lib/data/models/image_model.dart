import 'package:dog_test/domain/entities/image_entity.dart';

class ImageModel {
  final String message;
  final String status;

  ImageModel({
    required this.message,
    required this.status,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    message: json["message"],
    status: json["status"],
  );

  ImageEntity convertToEntity(){
    return ImageEntity(message: message, status: status);
  }
}