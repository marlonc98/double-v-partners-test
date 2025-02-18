import 'package:doublevpartners/data/repositories/maps/api/impl/get_current_location_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_location_by_lay_long_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_locations_by_key_word_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/impl/get_locations_form_maps_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/save_location_api_impl.dart';
import 'package:doublevpartners/data/repositories/maps/api/search_user_locations_api_impl.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:either_dart/either.dart';
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
