import 'package:dio/dio.dart';
import 'package:network_manager/src/models/location.dart';

import 'models/character.dart';

abstract class NetworkManager {
  void init();

  Future<List<Character>> getAllCharacters();

  Future<List<LocationData>> getAllLocations();
}

class NetworkManagerImp extends NetworkManager {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api/',
      connectTimeout: 4000,
      receiveTimeout: 4000,
      sendTimeout: 4000,
    ),
  );

  @override
  void init() {
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
  }

  @override
  Future<List<Character>> getAllCharacters() async {
    int page = 1;
    final characters = <Character>[];

    await Future.doWhile(() async {
      final response = await _dio.get(
        'character',
        queryParameters: {'page': page},
      );
      final responseChars =
          CharacterRequestModel.fromJson(response.data).results;
      characters.addAll(responseChars);
      page++;
      return page != 30;
    });

    return characters;
  }

  @override
  Future<List<LocationData>> getAllLocations() async {
    int page = 1;
    final locations = <LocationData>[];

    await Future.doWhile(() async {
      final response = await _dio.get(
        'location',
        queryParameters: {'page': page},
      );
      final responseChars =
          LocationsRequestModel.fromJson(response.data).results;
      locations.addAll(responseChars);
      page++;
      return page != 2;
    });

    return locations;
  }
}
