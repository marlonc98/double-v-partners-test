class LocationEntity {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;
  String? apartment;
  String? mapsName;
  String? mapsAddress;
  double? mapsLong;
  double? mapsLat;
  String? placeId;

  LocationEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.apartment,
    this.mapsName,
    this.mapsAddress,
    this.mapsLat,
    this.mapsLong,
    this.placeId,
  });
}
