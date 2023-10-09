import 'dart:io';
import 'package:dog_test/core/constants/assets.dart';
import 'package:dog_test/presentation/pages/random_images/random_images_bloc.dart';
import 'package:dog_test/presentation/pages/random_images/random_images_event.dart';
import 'package:dog_test/presentation/pages/random_images/random_images_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RandomImagesView extends StatefulWidget {
  String name;
   RandomImagesView({super.key,required this.name});

  @override
  State<RandomImagesView> createState() => _RandomImagesViewState();
}

class _RandomImagesViewState extends State<RandomImagesView> {
  late RandomImagesBloc _randomImagesBloc;

  @override
  void initState() {
    _randomImagesBloc = BlocProvider.of(context);
    _randomImagesBloc.add(FetchRandomImageEvent(widget.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomImagesBloc, RandomImageState>(
      bloc: _randomImagesBloc,
      builder: (context, state) {
        if (state is FetchRandomImageComplatedState) {

          return InkWell(
            onTap: () {
              _randomImagesBloc.add(FetchRandomImageEvent(widget.name));
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: 265,
                        width: 256,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 217,
                              width: 217,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.file(
                                    File(
                                      state.path,
                                    ),
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height * .4,
                                    width: MediaQuery.of(context).size.width * .9,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: SvgPicture.asset(
                                  Assets.closeIcon,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 56,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Generate",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color.fromRGBO(0, 133, 255, 1)),
            ),
          );
        } else {
          return Center(
            child: Text("loading"),
          );
        }
      },
    );
  }
}
