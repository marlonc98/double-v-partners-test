import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';

class GetLocationByKeyWordUseCase {
  MapsRepository mapsRepository;

  GetLocationByKeyWordUseCase({required this.mapsRepository});

  Future<List<MapLocationEntity>> call(String keyWord) {
    return mapsRepository.getLocationsByKeyWord(keyWord);
  }
}
