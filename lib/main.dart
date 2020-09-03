import 'package:app.gridpicture/blocs/app/bloc.dart';
import 'package:app.gridpicture/helpers/file_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:app.gridpicture/repositories/chat_repository.dart';
import 'package:app.gridpicture/widgets/restart_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app.gridpicture/config/routes.dart';
import 'package:app.gridpicture/bloc_delegate.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'language.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(RestartApp(child: App()));
}

class App extends StatelessWidget {
  static StorageInfo storageInfo;


  @override
  Widget build(BuildContext context) {
    FileHelper.createAppDirectories();

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
        child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if(state.isAuthenticated) {
                ChatRepository.initialize(state.token);
              }
            },
            child: BlocBuilder<AppBloc, AppState>(
              condition: (currentState, comingState) {
                return comingState.language != currentState.language;
              },
              builder: (context, state) {
                Intl.defaultLocale = state.language;
                return MaterialApp(
                  title: 'Caiwai',
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
//                    brightness: Brightness.light,
//                    primaryColor: Colors.red,
                    brightness: Brightness.dark,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  initialRoute: Routes.splash,  //set default route
                  onGenerateRoute: Routes.appRoutes,
                );
              },
            )
        )
    );
  }
}