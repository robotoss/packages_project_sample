import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_manager/network_manager.dart';

part 'locations_page_event.dart';
part 'locations_page_state.dart';

class LocationsPageBloc extends Bloc<LocationPageEvent, LocationPageState> {
  LocationsPageBloc(this._networkManager)
      : super(const LocationPageInitialState()) {
    on<LocationPageInitEvent>(_buildLoadDataHomeEvent);
    on<LocationPageShowLocationEvent>(_buildLocationPageShowLocationEvent);
    on<LocationPageFailedEvent>((event, emit) => emit(
          LocationPageInitFailureState(errorMessage: event.errorMessage),
        ));
  }

  final NetworkManager _networkManager;

  Future<void> _buildLoadDataHomeEvent(
    LocationPageInitEvent event,
    Emitter<LocationPageState> emit,
  ) async {
    emit(const LocationPageInitialState());
    final locations = await _networkManager.getAllLocations();
    emit(LocationPageDataState(locations: locations));
  }

  Future<void> _buildLocationPageShowLocationEvent(
    LocationPageShowLocationEvent event,
    Emitter<LocationPageState> emit,
  ) async {
    emit(LocationPageDataState(locations: event.locations));
  }
}
