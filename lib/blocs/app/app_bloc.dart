import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  static AppBloc of(context) => BlocProvider.of<AppBloc>(context);

  AppBloc() {
    this.add(AppStarted());
  }


  @override
  AppState get initialState => AppState(language: 'en');

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      await Future.delayed(Duration(seconds: 1));
      yield state.authenticated();
    } else if(event is SwitchLanguage) {
      yield state.switchLanguage(event.language);
    }
  }
}
