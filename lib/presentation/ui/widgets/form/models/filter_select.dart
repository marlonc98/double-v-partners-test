import 'filter_option.dart';

enum TypeFilterSelect { choice, radio, multiple }

class FilterSelect {
  String keyName;
  String displayName;
  TypeFilterSelect typeFilterSelect;
  List<FilterOption> options;
  List<FilterOption> selectedOptions;

  FilterSelect(
      {required this.displayName,
      required this.keyName,
      required this.typeFilterSelect,
      this.options = const [],
      this.selectedOptions = const []});
}
