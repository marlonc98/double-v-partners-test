import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapsRepository {
  Future<MapLocationEntity?> getLocationByLatLong(double lat, double long);
  Future<List<MapLocationEntity>> getLocationsByKeyWord(String keyword);
  Future<MapLocationEntity?> getLocationById(String id);
  Future<Position?> getCurrentLocation();
  Future<Either<ExceptionEntity, void>> saveLocation(
    MapLocationEntity location,
    String userId,
  );
  Future<Either<ExceptionEntity, SearchResultEntity<MapLocationEntity>>>
  searchUserLocations({
    required int page,
    required String query,
    required int itemsPerPage,
    required String userId,
  });
}
