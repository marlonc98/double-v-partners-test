import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ViewModel<T> with ChangeNotifier {
  T widget;
  BuildContext context;
  GetIt getIt = GetIt.instance;
  late LocalizationState localization;
  bool Function() isMounted;
  bool _isDisposed = false;
  bool get mounted => isMounted();

  ViewModel({
    required this.context,
    required this.widget,
    bool Function()? isMounted,
  }) : isMounted = isMounted ?? (() => true) {
    this.localization = Provider.of<LocalizationState>(context);
  }

  @override
  notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
