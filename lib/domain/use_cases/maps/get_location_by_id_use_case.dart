import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';

class GetLocationByIdUseCase {
  MapsRepository mapsRepository;

  GetLocationByIdUseCase({required this.mapsRepository});

  Future<MapLocationEntity?> call(String id) {
    return mapsRepository.getLocationById(id);
  }
}
