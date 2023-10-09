import 'package:dog_test/presentation/bottom/app.dart';
import 'package:dog_test/presentation/pages/home/home_bloc.dart';
import 'package:dog_test/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case App.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeBloc>.value(
            value: args as HomeBloc,
            child: const App(),
          ),
        );

      case SplashPage.id:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeBloc>.value(
            value: HomeBloc(),
            child: const SplashPage(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error Page'),
        ),
      );
    });
  }
}
