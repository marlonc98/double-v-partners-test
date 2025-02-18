import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:geolocator/geolocator.dart';

MapLocationEntity mapLocationEntity = MapLocationEntity(
  address: "Calle 1",
  id: "1",
  name: "Calle 1",
  lat: 74.3222332,
  lng: -76.3222332,
);

class MapsRepositoryFake extends MapsRepository {
  @override
  Future<MapLocationEntity?> getLocationById(String id) {
    return Future.value(mapLocationEntity);
  }

  @override
  Future<MapLocationEntity?> getLocationByLatLong(double lat, double long) =>
      Future.value(mapLocationEntity);

  @override
  Future<List<MapLocationEntity>> getLocationsByKeyWord(String keyword) =>
      Future.value([
        mapLocationEntity,
        mapLocationEntity,
        mapLocationEntity,
        mapLocationEntity,
        mapLocationEntity,
        mapLocationEntity,
      ]);

  @override
  Future<Position?> getCurrentLocation() => Future.value(
    Position(
      latitude: 74.3222332,
      longitude: -76.3222332,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      headingAccuracy: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
    ),
  );
}
