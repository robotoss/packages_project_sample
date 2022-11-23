part of 'characters_page_bloc.dart';

@immutable
abstract class CharactersPageEvent {}

class CharactersPageInitEvent extends CharactersPageEvent {}

class CharactersPageShowCharactersEvent extends CharactersPageEvent {
  CharactersPageShowCharactersEvent({required this.characters});

  final List<Character> characters;
}

class CharactersPageFailedEvent extends CharactersPageEvent {
  CharactersPageFailedEvent({required this.errorMessage});

  final String errorMessage;
}
