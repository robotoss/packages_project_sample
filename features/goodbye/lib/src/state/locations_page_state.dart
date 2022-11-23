part of 'locations_page_bloc.dart';

@immutable
abstract class LocationPageState {
  const LocationPageState();
}

class LocationPageInitialState extends LocationPageState {
  const LocationPageInitialState();
}

class LocationPageDataState extends LocationPageState {
  const LocationPageDataState({required this.locations});

  final List<LocationData> locations;
}

class LocationPageInitFailureState extends LocationPageState {
  const LocationPageInitFailureState({required this.errorMessage});

  final String errorMessage;
}
