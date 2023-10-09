import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  const TitleTextWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
     title,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Color.fromRGBO(0, 85, 211, 1)),
    );
  }
}

class SubTitleTextWidget extends StatelessWidget {
  final String title;
  const SubTitleTextWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
     title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}