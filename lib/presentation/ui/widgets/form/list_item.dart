import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final String? title, value;
  final String? validator;
  final VoidCallback? onTap, onEdit, onDelete;
  final List<Widget> aditionalOptions;
  final Widget? image;
  final Color? backgroundColor, textColor, iconsColor, titleColor;
  const ListItem(
      {super.key,
      required this.title,
      required this.value,
      this.onTap,
      this.onDelete,
      this.validator,
      this.aditionalOptions = const [],
      this.backgroundColor,
      this.titleColor,
      this.textColor,
      this.iconsColor,
      this.image,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            // color: p Theme.of(context).cardColor,
            color: backgroundColor ??
                Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                width: 0.8),
          ),
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Container(
            padding: EdgeInsets.only(right: 8, bottom: 16, top: 16),
            decoration: BoxDecoration(
                // border: Border(
                //     bottom: BorderSide(color: Color(0xFFDFDFDF), width: 0.5)),
                ),
            child: Row(
              children: [
                image ?? Container(),
                image != null ? SizedBox(width: 16) : Container(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title != null
                        ? Text(title!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: titleColor ??
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ))
                        : Container(),
                    title != null && value != null
                        ? SizedBox(
                            height: 2,
                          )
                        : Container(),
                    value != null
                        ? Text(
                            toBeginningOfSentenceCase(value) ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: textColor ??
                                    Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withAlpha(204)),
                          )
                        : Container(),
                    validator != null
                        ? Text(validator!, style: TextStyle(color: Colors.red))
                        : Container(),
                  ],
                )),
                onTap != null && onDelete == null && aditionalOptions.isEmpty
                    ? Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      )
                    : Container(),
                onEdit != null
                    ? IconButton(
                        icon: Icon(Icons.edit, color: iconsColor),
                        onPressed: onEdit,
                      )
                    : Container(),
                onDelete != null
                    ? IconButton(
                        icon: Icon(Icons.delete, color: iconsColor),
                        onPressed: onDelete)
                    : Container(),
                ...aditionalOptions,
              ],
            ),
          )),
    );
  }
}
