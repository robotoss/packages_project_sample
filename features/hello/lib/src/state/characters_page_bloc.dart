import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_manager/network_manager.dart';

part 'characters_page_event.dart';
part 'characters_page_state.dart';

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  CharactersPageBloc(this._networkManager)
      : super(const CharactersPageInitialState()) {
    on<CharactersPageInitEvent>(_buildLoadDataHomeEvent);
    on<CharactersPageShowCharactersEvent>(
        _buildCharactersPageShowCharactersEvent);
    on<CharactersPageFailedEvent>((event, emit) => emit(
          CharactersPageInitFailureState(errorMessage: event.errorMessage),
        ));
  }

  final NetworkManager _networkManager;

  Future<void> _buildLoadDataHomeEvent(
    CharactersPageInitEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    emit(const CharactersPageInitialState());
    final characters = await _networkManager.getAllCharacters();
    emit(CharactersPageDataState(characters: characters));
  }

  Future<void> _buildCharactersPageShowCharactersEvent(
    CharactersPageShowCharactersEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    emit(CharactersPageDataState(characters: event.characters));
  }
}
