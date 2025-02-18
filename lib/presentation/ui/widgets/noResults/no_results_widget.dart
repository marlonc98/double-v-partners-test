import 'package:flutter/material.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_outlined),
        SizedBox(
          height: 8,
        ),
        //TODO change to localization
        Text('No se encontró contrato'),
      ],
    ));
  }
}
