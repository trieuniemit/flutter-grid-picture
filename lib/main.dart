import 'package:com.codestagevn.gridpicture/blocs/app/bloc.dart';
import 'package:com.codestagevn.gridpicture/helpers/file_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:com.codestagevn.gridpicture/services/admob.dart';
import 'package:com.codestagevn.gridpicture/widgets/restart_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:com.codestagevn.gridpicture/config/routes.dart';
import 'package:com.codestagevn.gridpicture/bloc_delegate.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'language.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(RestartApp(child: App()));

  FileHelper.createAppDirectories();
  AdmobService.init();
}

class App extends StatelessWidget {
  static String version = '1.0';

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return BlocProvider<AppBloc>(
      create: (BuildContext context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
            condition: (currentState, comingState) {
              return comingState.language != currentState.language;
            },
            builder: (context, state) {
              Intl.defaultLocale = state.language;
              return MaterialApp(
                title: 'Grid Pictures',
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: AppLg.getLocales,
                localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
                  if (locale == null) {
                    print("Language locale is null!!. Set support to first!");
                    return supportedLocales.first;
                  }
                  for (Locale supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                locale: Locale(state.language),
                theme: ThemeData(
                  primaryColor: Colors.white
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                initialRoute: Routes.home,  //set default route
                onGenerateRoute: Routes.appRoutes,
              );
            },
          )
      );
  }
}