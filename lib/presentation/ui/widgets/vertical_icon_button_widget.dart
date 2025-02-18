import 'package:flutter/material.dart';

class VerticalIconButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData iconData;

  const VerticalIconButtonWidget(
      {super.key,
      required this.onTap,
      required this.text,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                iconData,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              )
            ],
          ),
        ));
  }
}
