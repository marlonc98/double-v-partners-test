import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';

class MapLocationGmapsFromPredictionDto {
  static MapLocationEntity fromJson(Map<String, dynamic> json) {
    return MapLocationEntity(
      id: json['place_id'],
      name: json['structured_formatting']['main_text'],
      address: json['structured_formatting']['secondary_text'],
      lat: null,
      lng: null,
    );
  }
}
