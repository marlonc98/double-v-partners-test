import 'package:doublevpartners/domain/entities/map_location_entity.dart';

class MapLocationGmapsFromIdDto {
  static MapLocationEntity fromJson(Map<String, dynamic> json) {
    return MapLocationEntity(
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      id: json['place_id'],
      address: json['formatted_address'],
    );
  }
}
