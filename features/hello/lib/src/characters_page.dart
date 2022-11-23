import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/src/state/characters_page_bloc.dart';
import 'package:network_manager/network_manager.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersPageBloc>(
      create: (_) => CharactersPageBloc(
        context.read<NetworkManager>(),
      )..add(CharactersPageInitEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Characters')),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersPageBloc, CharactersPageState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case CharactersPageInitialState:
            return const _LoadingWidget();
          case CharactersPageDataState:
            return _DataWidget(
              characters: (state as CharactersPageDataState).characters,
            );
          case CharactersPageInitFailureState:
            return _ErrorWidget(
              error: (state as CharactersPageInitFailureState).errorMessage,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget({Key? key, required this.characters}) : super(key: key);
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (_, index) => _CharacterCard(characters[index]),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard(this.character, {Key? key}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              character.image,
              width: 90,
              height: 90,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  _CharacterInfo(
                    title: 'Name',
                    value: character.name,
                  ),
                  _CharacterInfo(
                    title: 'Gender',
                    value: character.gender,
                  ),
                  _CharacterInfo(
                    title: 'Species',
                    value: character.species,
                  ),
                  _CharacterInfo(
                    title: 'Status',
                    value: character.status,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({
    Key? key,
    required this.title,
    required this.value,
    this.isLast = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0.0 : 8.0),
      child: Row(
        children: [
          Text('$title:', style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 10),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key, required this.error}) : super(key: key);
  final String error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CharactersPageBloc>().add(
                  CharactersPageInitEvent(),
                ),
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
