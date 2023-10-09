import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String name;
  CustomAppBar({super.key,required this.name}) : super(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
  );
}
