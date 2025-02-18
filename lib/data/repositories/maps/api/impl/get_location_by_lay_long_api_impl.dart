import 'dart:convert';

import 'package:doublevpartners/data/gmapsApi/gmaps_api.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_locations_form_maps_api_impl.dart';
import 'package:doublevpartners/domain/entities/map_location_entity.dart';

Future<MapLocationEntity?> getLocationByLatLongApiImpl(
  double lat,
  double long,
) async {
  String relativeUrl = "/geocode/json?latlng=$lat,$long";
  dynamic responseText = await GmapsApi().get(relativeUrl);
  if (responseText == null) return null;
  Map<String, dynamic> response = jsonDecode(responseText)?['results']?[0];
  return await getLocationsFromMapsApiImpl(response['place_id']);
}
