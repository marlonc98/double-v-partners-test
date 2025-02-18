import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';

class GetLocationByLatLngUseCase {
  MapsRepository mapsRepository;

  GetLocationByLatLngUseCase({required this.mapsRepository});

  Future<MapLocationEntity?> call(double lat, double lng) {
    return mapsRepository.getLocationByLatLong(lat, lng);
  }
}
