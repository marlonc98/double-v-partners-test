import 'dart:convert';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, SearchResultEntity<MapLocationEntity>>>
searchUserLocationsApiImpl({
  required int page,
  required String query,
  required int itemsPerPage,
  required String userId,
}) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> locationsSp = sp.getStringList("${userId}_locations") ?? [];

    List<MapLocationEntity> allLocations =
        locationsSp
            .map((location) => MapLocationEntity.fromJson(jsonDecode(location)))
            .toList();

    List<MapLocationEntity> filteredLocations =
        allLocations
            .where((location) => location.name.contains(query))
            .toList();

    int totalItems = filteredLocations.length;
    int totalPages = (totalItems / itemsPerPage).ceil();

    List<MapLocationEntity> paginatedLocations =
        filteredLocations
            .skip((page - 1) * itemsPerPage)
            .take(itemsPerPage)
            .toList();

    return Right(
      SearchResultEntity(
        currentPage: page,
        totalItems: totalItems,
        data: paginatedLocations,
        itemsPerPage: itemsPerPage,
        lastpage: totalPages,
      ),
    );
  } on Exception catch (e) {
    print("error on searchUserLocationsApiImpl: $e");
    return Left(ExceptionEntity.fromException(e));
  }
}
