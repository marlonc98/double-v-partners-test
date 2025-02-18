import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ErrorPaginatorWidget extends StatelessWidget {
  final PagingController pagingcontroller;

  const ErrorPaginatorWidget({super.key, required this.pagingcontroller});

  @override
  Widget build(BuildContext context) {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Big text, medium text, then elevated button with text and icon
          Text(
            localization.translate(KeyWordsLocalization.ErrorPaginatorTitle),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            pagingcontroller.error.toString(),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: pagingcontroller.refresh,
            icon: Icon(Icons.refresh),
            label: Text(
              localization.translate(KeyWordsLocalization.ErrorPaginatorRetry),
            ),
          ),
        ],
      ),
    );
  }
}
