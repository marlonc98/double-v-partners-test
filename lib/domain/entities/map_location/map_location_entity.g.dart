// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_location_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapLocationEntityImpl _$$MapLocationEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MapLocationEntityImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$MapLocationEntityImplToJson(
  _$MapLocationEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'lat': instance.lat,
  'lng': instance.lng,
};
