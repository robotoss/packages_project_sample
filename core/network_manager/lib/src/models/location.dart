import 'dart:convert';

LocationsRequestModel locationsModelFromJson(String str) =>
    LocationsRequestModel.fromJson(json.decode(str));

class LocationsRequestModel {
  LocationsRequestModel({
    required this.info,
    required this.results,
  });

  final InfoLocations info;
  final List<LocationData> results;

  factory LocationsRequestModel.fromJson(Map<String, dynamic> json) =>
      LocationsRequestModel(
        info: InfoLocations.fromJson(json["info"]),
        results: List<LocationData>.from(
            json["results"].map((x) => LocationData.fromJson(x))),
      );
}

class InfoLocations {
  InfoLocations({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory InfoLocations.fromJson(Map<String, dynamic> json) => InfoLocations(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}

class LocationData {
  LocationData({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final DateTime created;

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}
