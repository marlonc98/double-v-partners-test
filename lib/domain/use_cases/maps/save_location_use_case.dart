import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/repositories/maps_repository.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:either_dart/either.dart';

class SaveLocationUseCase {
  final MapsRepository mapsRepository;
  final UserState userState;

  SaveLocationUseCase({required this.mapsRepository, required this.userState});

  Future<Either<ExceptionEntity, void>> call({
    required MapLocationEntity location,
  }) async {
    return await mapsRepository.saveLocation(location, userState.user!.id!);
  }
}
