import 'dart:io';
import 'package:dog_test/core/constants/assets.dart';
import 'package:dog_test/core/extension/screen_size.dart';
import 'package:dog_test/core/helper/keyboard_unfocus.dart';
import 'package:dog_test/presentation/pages/random_images/random_images_bloc.dart';
import 'package:dog_test/presentation/pages/random_images/random_images_view.dart';
import 'package:dog_test/presentation/widget/custom_app_bar.dart';
import 'package:dog_test/presentation/widget/image_widget.dart';
import 'package:dog_test/presentation/widget/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'home_bloc.dart';
import 'home_state.dart';

///Animasyonlu TextField için sanal klavyenin açık olduğundan emin olunuz!
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isFocus;
  late final FocusNode _focusNode;

  late final TextEditingController _controller;

  late List<Breed> _filteredBreeds;

  late double _containerHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFocus = false;
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _filteredBreeds = [];
    _containerHeight = 110;
    _focusNode.addListener(() => _focusNodeListener());
  }

  void _focusNodeListener() {
    if (_focusNode.hasFocus) {
      setState(() {
        _isFocus = true;
      });
    } else {
      setState(() {
        _containerHeight = 110;
        _isFocus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    double bottomHeight = padding.bottom + 16;
    return KeyboardFocus.unFocus(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppBar(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchAllDogBreedsComplatedState) {
              final breeds = state.breeds;

              if (_controller.text.isNotEmpty) {
                _filteredBreeds = breeds.where((breed) {
                  return breed.title.toLowerCase().contains(_controller.text.toLowerCase());
                }).toList();
              } else {
                _filteredBreeds = List.from(breeds);
              }

              return Stack(
                children: [
                  _filteredBreeds.isNotEmpty ? _buildGridView() : _isEmptyWidget(),
                  !_isFocus ? _fakeTextfieldWidget(bottomHeight) : _buildTextfield(context),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Positioned _buildTextfield(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isFocus = !_isFocus;
            });
          },
          onVerticalDragUpdate: (details) => _containerSizeListener(details, context),
          child: animatedContainer(),
        ),
      ),
    );
  }

  AnimatedContainer animatedContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: _containerHeight,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 16,
            spreadRadius: 0,
            color: Colors.black.withOpacity(.16),
          )
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border.all(width: 2, color: const Color(0xffE5E5EA)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 32,
            color: const Color(0xffE5E5EA),
          ),
          TextField(
            controller: _controller,
            onChanged: (value) => setState(() {}),
            focusNode: _focusNode,
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
            ),
          ),
        ],
      ),
    );
  }

  void _containerSizeListener(DragUpdateDetails details, BuildContext context) {
    if (details.delta.dy < 0) {
      setState(() {
        if (_containerHeight == 110) {
          _containerHeight += MediaQuery.of(context).size.height / 2;
        }
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        if (_containerHeight > 110) {
          _containerHeight = 110;
        }
      });
    }
  }

  Positioned _fakeTextfieldWidget(double bottomHeight) {
    return Positioned.fill(
      bottom: bottomHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isFocus = !_isFocus;
            });
          },
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 16,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.16),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: const Color(0xffE5E5EA)),
            ),
            child: Text(
              "Search",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3C3C4399).withOpacity(.6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _isEmptyWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "No results found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            "Try searching with another word",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(60, 60, 67, .6),
            ),
          ),
        ),
      ],
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      itemCount: _filteredBreeds.length,
      padding: const EdgeInsets.only(bottom: 200, right: 8, left: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [_imageBuilder(context, index), titleBuilder(index)],
          ),
        );
      },
    );
  }

  Positioned titleBuilder(int index) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Text(
        _filteredBreeds[index].title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  InkWell _imageBuilder(BuildContext context, int index) {
    return InkWell(
      onTap: () => _showPopUp(context, index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Image.file(
          File(
            _filteredBreeds[index].path,
          ),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  void _showPopUp(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        elevation: 10,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [_popUpImage(index, context), const SizedBox(height: 12), _popUpContent(context, index)],
            ),
          ),
        ),
      ),
    );
  }

  Padding _popUpContent(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleTextWidget(title: "Breed"),
            const Divider(
              color: Colors.grey,
            ),
            SubTitleTextWidget(title: _filteredBreeds[index].title),
            const SizedBox(height: 12),
            TitleTextWidget(title: "Sub Breed"),
            const Divider(
              color: Colors.grey,
            ),
            Column(
              children: List.generate(
                _filteredBreeds[index].subTitle.length,
                (indexForSubtitle) => SubTitleTextWidget(
                  title: _filteredBreeds[index].subTitle[indexForSubtitle],
                ),
              ),
            ),
            const Spacer(),
            BlocProvider.value(
              value: RandomImagesBloc(),
              child: RandomImagesView(
                name: _filteredBreeds[index].title,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Stack _popUpImage(int index, BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          child: Container(
            alignment: Alignment.center,
            child: CustomeImageWidget(
              path: _filteredBreeds[index].path,
              width: context.screenWidth * .9,
              height: context.screenHeight * .4,
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                Assets.closeIcon,
              ),
            ),
          ),
        )
      ],
    );
  }

  CustomAppBar _buildCustomAppBar() => CustomAppBar(name: "AppName");
}
