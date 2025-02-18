class MapLocationEntity {
  String id;
  String name;
  String address;
  double? lat;
  double? lng;

  MapLocationEntity(
      {required this.id,
      required this.name,
      required this.address,
      this.lat,
      this.lng});
}
