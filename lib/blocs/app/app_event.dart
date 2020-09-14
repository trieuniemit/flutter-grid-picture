import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object> get props => [];
}

class SwitchLanguage extends AppEvent {
  final String language;
  const SwitchLanguage(this.language);
  @override
  List<Object> get props => [language];
}
