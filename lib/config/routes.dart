import 'package:app.gridpicture/screens/splash_screen.dart';
import 'package:app.gridpicture/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:app.gridpicture/screens/main_screen.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';

  static Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return CupertinoPageRoute(builder:(context) => SplashScreen());
      case welcome:
        return CupertinoPageRoute(builder:(context) => WelcomeScreen());
      case home:
        return CupertinoPageRoute(builder:(context) => MainScreen());
    }

    return CupertinoPageRoute(builder:(context) => SplashScreen());
  }

  static Future<dynamic> pushTo(BuildContext context, Widget screen ) async {
    return Navigator.of(context).push(CupertinoPageRoute(builder:(context) => screen));
  }
}

