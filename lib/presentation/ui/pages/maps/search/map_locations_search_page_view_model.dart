import 'package:doublevpartners/domain/use_cases/maps/save_location_use_case.dart';
import 'package:doublevpartners/presentation/routes/view_model.dart';
import 'package:doublevpartners/presentation/ui/widgets/mapSetPositon/map_set_position_page.dart';
import 'package:doublevpartners/presentation/ui/widgets/modals/show_modal.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:doublevpartners/domain/entities/search_result_entity.dart';
import 'package:doublevpartners/domain/use_cases/maps/search_user_locations_use_case.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page.dart';

class MapLocationsSearchPageViewModel
    extends ViewModel<MapLocationsSearchPage> {
  MapLocationsSearchPageViewModel({
    required super.context,
    required super.widget,
    required super.isMounted,
  }) {
    _initPagingController();
  }

  void retry() {
    _searchUserLocations();
    notifyListeners();
  }

  PagingController<int, MapLocationEntity> pagingController = PagingController(
    firstPageKey: 1,
  );
  int page = 1;
  final _itemsPerPage = 10;
  String query = '';

  void _initPagingController() {
    pagingController.addPageRequestListener((pageKey) {
      page = pageKey;
      _searchUserLocations();
    });
  }

  void _searchUserLocations() async {
    Either<ExceptionEntity, SearchResultEntity<MapLocationEntity>> result =
        await getIt.get<SearchUserLocationsUseCase>().call(
          page: page,
          query: query,
          itemsPerPage: _itemsPerPage,
        );

    if (result.isLeft) {
      if (mounted) {
        ShowModal.showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: result.left.code,
          error: true,
        );
      }
      pagingController.error = result.left.message;
    } else {
      final searchResult = result.right;
      final isLastPage = searchResult.currentPage == searchResult.lastpage;
      if (isLastPage) {
        pagingController.appendLastPage(searchResult.data);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(searchResult.data, nextPageKey);
      }
    }
  }

  Future<void> getMapLocationDetails(MapLocationEntity mapLocation) async {
    MapLocationEntity? response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSetPositionPage(initialPosition: mapLocation),
      ),
    );

    if (response != null && mounted) {
      mapLocation = response;
      notifyListeners();
    }
  }

  Future<void> handleSearch(String word) async {
    query = word;
    page = 1;
    pagingController.refresh();
  }

  void addLocation() async {
    MapLocationEntity? viewResponse = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSetPositionPage(initialPosition: null),
      ),
    );

    if (viewResponse != null) {
      Either<ExceptionEntity, void> result = await getIt
          .get<SaveLocationUseCase>()
          .call(location: viewResponse);

      if (result.isLeft) {
        if (mounted) {
          ShowModal.showSnackBar(
            // ignore: use_build_context_synchronously
            context: context,
            text: result.left.code,
            error: true,
          );
        }
      } else {
        if (mounted) {
          //reset search
          query = '';
          page = 1;
          pagingController.refresh();

          ShowModal.showSnackBar(
            // ignore: use_build_context_synchronously
            context: context,
            text: "Location saved",
            error: false,
          );
        }
      }
    }
  }
}
