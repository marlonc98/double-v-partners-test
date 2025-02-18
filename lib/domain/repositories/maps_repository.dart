import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapsRepository {
  Future<MapLocationEntity?> getLocationByLatLong(double lat, double long);
  Future<List<MapLocationEntity>> getLocationsByKeyWord(String keyword);
  Future<MapLocationEntity?> getLocationById(String id);
  Future<Position?> getCurrentLocation();
}
