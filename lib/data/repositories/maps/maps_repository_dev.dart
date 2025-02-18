import 'package:doublevpartners/data/repositories/maps/api/impl/get_current_location_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_location_by_lay_long_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_locations_by_key_word_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_locations_form_maps_api_impl.dart';
import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:geolocator/geolocator.dart';

class MapsRepositoryDev extends MapsRepository {
  @override
  Future<MapLocationEntity?> getLocationById(String id) =>
      getLocationsFromMapsApiImpl(id);

  @override
  Future<MapLocationEntity?> getLocationByLatLong(double lat, double long) =>
      getLocationByLatLongApiImpl(lat, long);

  @override
  Future<List<MapLocationEntity>> getLocationsByKeyWord(String keyword) =>
      getLocationsByKeyWordApiImpl(keyword);

  @override
  Future<Position?> getCurrentLocation() => getCurrentLocationApiImpl();
}
