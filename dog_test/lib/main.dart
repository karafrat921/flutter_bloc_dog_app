import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/route_generator.dart';
import 'injection.dart' as di;
import 'presentation/pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.initializeDependencies();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'galanoGrotesque',
      ),
      initialRoute: SplashPage.id,
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
