import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_location_entity.freezed.dart';
part 'map_location_entity.g.dart';

@freezed
class MapLocationEntity with _$MapLocationEntity {
  const factory MapLocationEntity({
    required String id,
    required String name,
    required String address,
    double? lat,
    double? lng,
  }) = _MapLocationEntity;

  factory MapLocationEntity.fromJson(Map<String, dynamic> json) =>
      _$MapLocationEntityFromJson(json);
}
