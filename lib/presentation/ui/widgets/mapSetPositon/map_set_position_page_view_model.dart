import 'dart:async';
import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/domain/use_cases/maps/get_current_position_use_case.dart';
import 'package:doublevpartners/domain/use_cases/maps/get_location_by_id_use_case.dart';
import 'package:doublevpartners/domain/use_cases/maps/get_location_by_key_word_use_case.dart';
import 'package:doublevpartners/domain/use_cases/maps/get_location_by_lat_lng_use_case.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/routes/view_model.dart';
import 'package:doublevpartners/presentation/ui/widgets/mapSetPositon/map_set_position_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSetPositionPageViewModel extends ViewModel<MapSetPositionPage>
    with WidgetsBindingObserver {
  MapSetPositionPageViewModel({required super.context, required super.widget}) {
    WidgetsBinding.instance.addObserver(this);
  }
  late GoogleMapController mapController;
  Timer? _gmapsInputTimer;
  double minChildSize = 0.0, maxChildSize = 0.7;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<MapLocationEntity> locationsRefered = [];
  MapLocationEntity? pickedMapLocation;
  DraggableScrollableController draggableController =
      DraggableScrollableController();
  String? styleMap;

  void getLocation() async {
    if (widget.initialPosition != null) {
      addMarkerLongPressed(
        LatLng(widget.initialPosition!.lat!, widget.initialPosition!.lng!),
      );
    } else {
      Position? currentLocation =
          await getIt.get<GetCurrentPositionUseCase>().call();
      if (currentLocation != null) {
        addMarkerLongPressed(
          LatLng(currentLocation.latitude, currentLocation.longitude),
        );
      }
    }
  }

  void _expandDraggable() {
    draggableController.animateTo(
      maxChildSize,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _collapseDraggable() {
    draggableController.animateTo(
      minChildSize,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void onKeyDownSearch(String? val) {
    if (val == null) {
      return;
    }
    if (_gmapsInputTimer != null) {
      _gmapsInputTimer!.cancel();
    }
    _gmapsInputTimer = Timer(Duration(milliseconds: 500), () async {
      List<MapLocationEntity> locations = await getIt
          .get<GetLocationByKeyWordUseCase>()
          .call(val);
      locationsRefered = locations;
      _expandDraggable();
      notifyListeners();
    });
  }

  void save() {
    Navigator.of(context).pop(pickedMapLocation);
  }

  Future addMarkerLongPressed(LatLng latlang) async {
    _addPickedMarker(latlang.latitude, latlang.longitude);
    //This is optional, it will zoom when the marker has been created
    MapLocationEntity? temp = await getIt
        .get<GetLocationByLatLngUseCase>()
        .call(latlang.latitude, latlang.longitude);
    pickedMapLocation =
        temp ??
        MapLocationEntity(
          id: '',
          name: localization.translate(
            KeyWordsLocalization.MapSetPositionPageViewModelWithoutLocation,
          ),
          address: latlang.toString(),
          lat: latlang.latitude,
          lng: latlang.longitude,
        );
    notifyListeners();
  }

  _addPickedMarker(double lat, double lng) {
    final MarkerId markerId = MarkerId("centred");
    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: LatLng(
        lat,
        lng,
      ), //With this parameter you automatically obtain latitude and longitude
      infoWindow: InfoWindow(
        title: localization.translate(
          KeyWordsLocalization.MapSetPositionPageViewModelMarkerTitle,
        ),
        snippet: localization.translate(
          KeyWordsLocalization.MapSetPositionPageViewModelMarkerSnippet,
        ),
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    markers[markerId] = marker;
    notifyListeners();
    mapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    detectThemeChange();
  }

  detectThemeChange() {
    changeMapTheme();
  }

  void changeMapTheme() async {
    String style = await rootBundle.loadString(
      "assets/config/${View.of(context).platformDispatcher.platformBrightness == Brightness.dark ? "dark" : "light"}_theme_maps.json",
    );
    styleMap = style;
    notifyListeners();
  }

  pickLocationFromPrediction(MapLocationEntity mapLocation) async {
    _collapseDraggable();
    MapLocationEntity? temp = await getIt.get<GetLocationByIdUseCase>().call(
      mapLocation.id,
    );
    pickedMapLocation = temp;
    notifyListeners();
    if (temp != null) {
      _addPickedMarker(temp.lat!, temp.lng!);
    } else {
      markers.clear();
    }
  }
}
