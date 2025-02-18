import 'package:doublevpartners/utils/strings_format.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserActionWidget extends StatelessWidget {
  String name;
  String description;
  String? photoUrl;

  UserActionWidget({
    super.key,
    required this.name,
    required this.description,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20,
                child:
                    photoUrl == null
                        ? Center(
                          child: Text(
                            StringsFormat.getFirstLetterAsCapitalize(
                              name,
                            ).substring(0, 2),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                        : Image.network(photoUrl!),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha(26),
        ),
      ],
    );
  }
}
