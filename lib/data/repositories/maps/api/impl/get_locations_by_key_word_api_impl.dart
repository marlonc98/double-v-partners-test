import 'dart:convert';
import 'package:doublevpartners/data/gmapsApi/dto/map_location_gmaps_from_prediction_dto.dart';
import 'package:doublevpartners/data/gmapsApi/gmaps_api.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';

Future<List<MapLocationEntity>> getLocationsByKeyWordApiImpl(
  String keyword,
) async {
  keyword = keyword.replaceAll(' ', '+');
  String relativeUrl =
      "/place/autocomplete/json?input=$keyword&sensor=false&libraries=places";
  dynamic responseText = await GmapsApi().get(relativeUrl);
  if (responseText == null) return [];
  List<dynamic> response = jsonDecode(responseText)['predictions'];
  return response
      .map<MapLocationEntity>(
        (json) => MapLocationGmapsFromPredictionDto.fromJson(json),
      )
      .toList();
}
