import 'package:doublevpartners/domain/entities/map_location_entity.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/widgets/buttons/button_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/list_item.dart';
import 'package:doublevpartners/presentation/ui/widgets/mapSetPositon/map_set_position_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapSetPositionPage extends StatelessWidget {
  final MapLocationEntity? initialPosition;

  const MapSetPositionPage({super.key, required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapSetPositionPageViewModel>(
      create:
          (_) => MapSetPositionPageViewModel(context: context, widget: this),
      child: Consumer<MapSetPositionPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    style: viewModel.styleMap,
                    initialCameraPosition: CameraPosition(
                      target:
                          initialPosition != null
                              ? LatLng(
                                initialPosition!.lat!,
                                initialPosition!.lng!,
                              )
                              : LatLng(3.43722, -76.5225),
                      zoom: 14.4746,
                    ),
                    onLongPress: (latlang) {
                      viewModel.addMarkerLongPressed(
                        latlang,
                      ); //we will call this function when pressed on the map
                    },
                    markers: viewModel.markers.values.toSet(),
                    padding: EdgeInsets.only(bottom: 60),
                    onMapCreated: (GoogleMapController controller) {
                      viewModel.mapController = controller;
                      viewModel.getLocation();
                      viewModel.changeMapTheme();
                    },
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(onChanged: viewModel.onKeyDownSearch),
                    ),
                  ),
                  if (viewModel.pickedMapLocation != null)
                    Positioned(
                      bottom: viewModel.locationsRefered.isNotEmpty ? 120 : 40,
                      left: 80,
                      right: 80,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(viewModel.pickedMapLocation!.name),
                            SizedBox(height: 8),
                            Text(viewModel.pickedMapLocation!.address),
                            SizedBox(height: 8),
                            ButtonWidget(
                              onTap: viewModel.save,
                              text: viewModel.localization.translate(
                                KeyWordsLocalization.Save,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  DraggableScrollableSheet(
                    controller: viewModel.draggableController,
                    initialChildSize: viewModel.minChildSize,
                    minChildSize: viewModel.minChildSize,
                    maxChildSize: viewModel.maxChildSize,
                    builder:
                        (context, scrollController) => SingleChildScrollView(
                          controller: scrollController,
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children:
                                    viewModel.locationsRefered
                                        .map(
                                          (location) => Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: ListItem(
                                              title: location.name,
                                              value: location.address,
                                              onTap:
                                                  () => viewModel
                                                      .pickLocationFromPrediction(
                                                        location,
                                                      ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
