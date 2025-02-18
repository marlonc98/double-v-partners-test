import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:doublevpartners/data/repositories/maps/api/save_location_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/search_user_locations_api_impl.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:either_dart/either.dart';

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

  @override
  Future<Either<ExceptionEntity, void>> saveLocation(
    MapLocationEntity location,
    String userId,
  ) async {
    return await saveLocationApiImpl(location: location, userId: userId);
  }

  @override
  Future<Either<ExceptionEntity, SearchResultEntity<MapLocationEntity>>>
  searchUserLocations({
    required int page,
    required String query,
    required int itemsPerPage,
    required String userId,
  }) async {
    return await searchUserLocationsApiImpl(
      page: page,
      query: query,
      itemsPerPage: itemsPerPage,
      userId: userId,
    );
  }
}
