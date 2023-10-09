import 'dart:io';

import 'package:dog_test/core/extension/screen_size.dart';
import 'package:flutter/material.dart';

class CustomeImageWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;

  const CustomeImageWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(
        path,
      ),
      fit: BoxFit.cover,
      height: height??context.screenHeight,
      width: width??context.screenWidth,
    );
  }
}
