import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  static AppBloc of(context) => BlocProvider.of<AppBloc>(context);

  @override
  AppState get initialState => AppState(language: 'en');

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if(event is SwitchLanguage) {
      yield state.switchLanguage(event.language);
    }
  }
}
