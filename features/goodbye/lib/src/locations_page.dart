import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodbye/src/state/locations_page_bloc.dart';
import 'package:network_manager/network_manager.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationsPageBloc>(
      create: (_) => LocationsPageBloc(
        context.read<NetworkManager>(),
      )..add(LocationPageInitEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Location')),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsPageBloc, LocationPageState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case LocationPageInitialState:
            return const _LoadingWidget();
          case LocationPageDataState:
            return _DataWidget(
              locations: (state as LocationPageDataState).locations,
            );
          case LocationPageInitFailureState:
            return _ErrorWidget(
              error: (state as LocationPageInitFailureState).errorMessage,
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
  const _DataWidget({Key? key, required this.locations}) : super(key: key);
  final List<LocationData> locations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (_, index) => _CharacterCard(locations[index]),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard(this.location, {Key? key}) : super(key: key);
  final LocationData location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _CharacterInfo(
                    title: 'Name',
                    value: location.name,
                  ),
                  _CharacterInfo(
                    title: 'Dimension',
                    value: location.dimension,
                  ),
                  _CharacterInfo(
                    title: 'Type',
                    value: location.type,
                  ),
                  _CharacterInfo(
                    title: 'Created',
                    value: location.created.toString(),
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
            onPressed: () => context.read<LocationsPageBloc>().add(
                  LocationPageInitEvent(),
                ),
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
