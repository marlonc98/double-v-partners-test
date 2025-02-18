import 'package:doublevpartners/data/repositories/maps/searcher_app_bar.dart';
import 'package:doublevpartners/presentation/ui/widgets/errorPaginator/error_paginator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page_view_model.dart';

class MapLocationsSearchPage extends StatefulWidget {
  static const String route = '/map-locations-search';

  const MapLocationsSearchPage({super.key});

  @override
  State<MapLocationsSearchPage> createState() => _MapLocationsSearchPageState();
}

class _MapLocationsSearchPageState extends State<MapLocationsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapLocationsSearchPageViewModel>(
      create:
          (_) => MapLocationsSearchPageViewModel(
            context: context,
            widget: widget,
            isMounted: () => mounted,
          ),
      child: Consumer<MapLocationsSearchPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SearcherAppBar(
                  title: 'Map Locations',
                  onSearch: viewModel.handleSearch,
                  waitSearch: true,
                ),
                PagedSliverList<int, MapLocationEntity>(
                  pagingController: viewModel.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<MapLocationEntity>(
                    firstPageErrorIndicatorBuilder:
                        (context) => ErrorPaginatorWidget(
                          pagingcontroller: viewModel.pagingController,
                        ),
                    noItemsFoundIndicatorBuilder:
                        (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No locations found.'),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: viewModel.addLocation,
                                child: Text('Add Location'),
                              ),
                            ],
                          ),
                        ),
                    itemBuilder:
                        (context, item, index) => Container(
                          margin: const EdgeInsets.only(
                            bottom: 8,
                            left: 16,
                            right: 16,
                          ),
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.address),
                            onTap: () => viewModel.getMapLocationDetails(item),
                          ),
                        ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: viewModel.addLocation,
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
