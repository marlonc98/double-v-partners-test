// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_location_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapLocationEntity _$MapLocationEntityFromJson(Map<String, dynamic> json) {
  return _MapLocationEntity.fromJson(json);
}

/// @nodoc
mixin _$MapLocationEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;

  /// Serializes this MapLocationEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapLocationEntityCopyWith<MapLocationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapLocationEntityCopyWith<$Res> {
  factory $MapLocationEntityCopyWith(
    MapLocationEntity value,
    $Res Function(MapLocationEntity) then,
  ) = _$MapLocationEntityCopyWithImpl<$Res, MapLocationEntity>;
  @useResult
  $Res call({String id, String name, String address, double? lat, double? lng});
}

/// @nodoc
class _$MapLocationEntityCopyWithImpl<$Res, $Val extends MapLocationEntity>
    implements $MapLocationEntityCopyWith<$Res> {
  _$MapLocationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            lat:
                freezed == lat
                    ? _value.lat
                    : lat // ignore: cast_nullable_to_non_nullable
                        as double?,
            lng:
                freezed == lng
                    ? _value.lng
                    : lng // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapLocationEntityImplCopyWith<$Res>
    implements $MapLocationEntityCopyWith<$Res> {
  factory _$$MapLocationEntityImplCopyWith(
    _$MapLocationEntityImpl value,
    $Res Function(_$MapLocationEntityImpl) then,
  ) = __$$MapLocationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String address, double? lat, double? lng});
}

/// @nodoc
class __$$MapLocationEntityImplCopyWithImpl<$Res>
    extends _$MapLocationEntityCopyWithImpl<$Res, _$MapLocationEntityImpl>
    implements _$$MapLocationEntityImplCopyWith<$Res> {
  __$$MapLocationEntityImplCopyWithImpl(
    _$MapLocationEntityImpl _value,
    $Res Function(_$MapLocationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _$MapLocationEntityImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        lat:
            freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                    as double?,
        lng:
            freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapLocationEntityImpl implements _MapLocationEntity {
  const _$MapLocationEntityImpl({
    required this.id,
    required this.name,
    required this.address,
    this.lat,
    this.lng,
  });

  factory _$MapLocationEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapLocationEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double? lat;
  @override
  final double? lng;

  @override
  String toString() {
    return 'MapLocationEntity(id: $id, name: $name, address: $address, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapLocationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, lat, lng);

  /// Create a copy of MapLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapLocationEntityImplCopyWith<_$MapLocationEntityImpl> get copyWith =>
      __$$MapLocationEntityImplCopyWithImpl<_$MapLocationEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MapLocationEntityImplToJson(this);
  }
}

abstract class _MapLocationEntity implements MapLocationEntity {
  const factory _MapLocationEntity({
    required final String id,
    required final String name,
    required final String address,
    final double? lat,
    final double? lng,
  }) = _$MapLocationEntityImpl;

  factory _MapLocationEntity.fromJson(Map<String, dynamic> json) =
      _$MapLocationEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  double? get lat;
  @override
  double? get lng;

  /// Create a copy of MapLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapLocationEntityImplCopyWith<_$MapLocationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
