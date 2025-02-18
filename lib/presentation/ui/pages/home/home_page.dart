import 'package:flutter/cupertino.dart';
import 'home_page_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (_) => HomePageViewModel(context: context, widget: this),
      child: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) => Placeholder(),
      ),
    );
  }
}
