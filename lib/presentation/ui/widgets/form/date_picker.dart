import 'dart:async';

import 'package:doublevpartners/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends FormField<DateTime> {
  final String title;
  final DateTime? defaultValue;
  final Function(dynamic value)? onChange;

  DatePicker({
    super.key,
    super.enabled = true,
    super.validator,
    this.onChange,
    required this.title,
    this.defaultValue,
  }) : super(
         builder: (FormFieldState<DateTime> state) {
           return DatePickerItem(
             title: title,
             errorText: state.errorText,
             defaultValue: defaultValue,
             onChange: (DateTime value) {
               state.didChange(value);
               onChange?.call(value);
             },
           );
         },
       );
}

class DatePickerItem extends StatefulWidget {
  final String? errorText;
  final String title;
  final Function(DateTime value)? onChange;
  final bool enabled;
  final DateTime? defaultValue;
  const DatePickerItem({
    super.key,
    this.errorText,
    this.defaultValue,
    this.onChange,
    this.enabled = true,
    required this.title,
  });
  @override
  State<DatePickerItem> createState() => _DatePickerItemState();
}

class _DatePickerItemState extends State<DatePickerItem> {
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.value = TextEditingValue(
      text:
          widget.defaultValue != null
              ? DateFormat('yyyy-MM-dd').format(widget.defaultValue!)
              : "",
    );
  }

  _openDate() async {
    print("is tapped $widget.enabled");
    if (!widget.enabled) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1920),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: (Theme.of(context).brightness == Brightness.light
                  ? ThemeData.light()
                  : ThemeData.dark())
              .copyWith(appBarTheme: AppBarTheme(color: COLOR_MAIN)),
          child: widget ?? Container(),
        );
      },
      initialDate: selectedDate ?? widget.defaultValue ?? DateTime(1990),
    );
    if (picked != null && (selectedDate != null || picked != selectedDate)) {
      widget.onChange?.call(picked);
      setState(() {
        selectedDate = picked;
      });
    }
    _dateController.value = TextEditingValue(
      text:
          selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
              : "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openDate,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.calendar_today_outlined),
          ),
          Expanded(
            child: TextField(
              onTap: _openDate,
              controller: _dateController,
              decoration: InputDecoration(
                hintText: widget.title,
                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                errorMaxLines: 2,
                border: UnderlineInputBorder(),
                hintStyle: TextStyle(color: Color(0xFF767676)),
                labelText: widget.title,
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Theme.of(context).primaryColor),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Theme.of(context).primaryColor,
                //     width: 2,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
