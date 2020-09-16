import 'package:com.codestagevn.gridpicture/screens/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.codestagevn.gridpicture/screens/main_screen.dart';

class Routes {
  static const String home = '/home';
  static const String setting = '/setting';

  static Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder:(context) => MainScreen());
      case setting:
        return CupertinoPageRoute(builder:(context) => SettingScreen());
    }
  }

  static Future<dynamic> pushTo(BuildContext context, Widget screen, {bool replace = false}) async {
    if(!replace) {
      return Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => screen));
    }

    return Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => screen));
  }
}

