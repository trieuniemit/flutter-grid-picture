
class AppState {
  final String language;

  AppState({this.language});

  AppState copyWith({String language}) => AppState(
      language: language ?? this.language
  );

  AppState switchLanguage(String language) => copyWith(
      language: language
  );

}