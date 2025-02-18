import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:either_dart/either.dart';

class SearchUserLocationsUseCase {
  final MapsRepository mapsRepository;
  final UserState userState;

  SearchUserLocationsUseCase({
    required this.mapsRepository,
    required this.userState,
  });

  Future<Either<ExceptionEntity, SearchResultEntity<MapLocationEntity>>> call({
    required int page,
    required String query,
    required int itemsPerPage,
  }) async {
    return await mapsRepository.searchUserLocations(
      page: page,
      query: query,
      itemsPerPage: itemsPerPage,
      userId: userState.user!.id!,
    );
  }
}
