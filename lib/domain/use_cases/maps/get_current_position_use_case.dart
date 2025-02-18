import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentPositionUseCase {
  MapsRepository mapsRepository;

  GetCurrentPositionUseCase({required this.mapsRepository});

  Future<Position?> call() {
    return mapsRepository.getCurrentLocation();
  }
}
