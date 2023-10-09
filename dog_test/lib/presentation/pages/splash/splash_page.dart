import 'package:dog_test/core/constants/assets.dart';
import 'package:dog_test/presentation/bottom/app.dart';
import 'package:dog_test/presentation/pages/home/home_bloc.dart';
import 'package:dog_test/presentation/pages/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_state.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_screen";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of(context);
    _homeBloc.add(FetchAllDogBreedsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is FetchAllDogBreedsComplatedState) {
              Navigator.of(context).pushReplacementNamed(App.id, arguments: _homeBloc);
            } else if (state is FetchAllDogBreedsErrorState) {
              debugPrint(state.message);
              _homeBloc.add(FetchAllDogBreedsEvent());
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.dogPhoto),
              const SizedBox(height: 10),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
