part of 'locations_page_bloc.dart';

@immutable
abstract class LocationPageEvent {}

class LocationPageInitEvent extends LocationPageEvent {}

class LocationPageShowLocationEvent extends LocationPageEvent {
  LocationPageShowLocationEvent({required this.locations});

  final List<LocationData> locations;
}

class LocationPageFailedEvent extends LocationPageEvent {
  LocationPageFailedEvent({required this.errorMessage});

  final String errorMessage;
}
