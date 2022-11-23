part of 'characters_page_bloc.dart';

@immutable
abstract class CharactersPageState {
  const CharactersPageState();
}

class CharactersPageInitialState extends CharactersPageState {
  const CharactersPageInitialState();
}

class CharactersPageDataState extends CharactersPageState {
  const CharactersPageDataState({required this.characters});

  final List<Character> characters;
}

class CharactersPageInitFailureState extends CharactersPageState {
  const CharactersPageInitFailureState({required this.errorMessage});

  final String errorMessage;
}
