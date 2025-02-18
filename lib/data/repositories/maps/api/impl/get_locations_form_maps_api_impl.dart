import 'dart:convert';

import 'package:doublevpartners/data/gmapsApi/dto/map_location_gmaps_from_id_dto.dart';
import 'package:doublevpartners/data/gmapsApi/gmaps_api.dart';
import 'package:doublevpartners/domain/entities/map_location_entity.dart';

Future<MapLocationEntity?> getLocationsFromMapsApiImpl(String id) async {
  String relativeUrl = "/place/details/json?place_id=$id";
  dynamic responseText = await GmapsApi().get(relativeUrl);
  if (responseText == null) return null;
  Map<String, dynamic> response = jsonDecode(responseText)['result'];
  return MapLocationGmapsFromIdDto.fromJson(response);
}
