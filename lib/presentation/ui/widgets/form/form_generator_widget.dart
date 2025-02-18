import 'package:flutter/material.dart';
import 'form_widget.dart';

// ignore: must_be_immutable
class FormGeneratorWidget extends StatefulWidget {
  final List<Widget> formWidgets;
  final Function() onSubmit;
  Map<String, dynamic> values;
  bool continueOnLast;

  FormGeneratorWidget({
    super.key,
    required this.formWidgets,
    required this.onSubmit,
    this.continueOnLast = true,
    this.values = const {},
  });

  @override
  State<FormGeneratorWidget> createState() => _FormGeneratorWidgetState();
}

class _FormGeneratorWidgetState<T> extends State<FormGeneratorWidget> {
  List<Widget> render = [];
  List<Widget> items = [];
  List<Widget> itemsAssigned = [];

  @override
  void initState() {
    _refill();
    super.initState();
  }

  _refill() {
    setState(() {
      items = widget.formWidgets;
      render = _filter();
    });
  }

  void _handleNextFocus(FormWidget field) {
    List<FormWidget> filtred = items
        .where((element) => element is FormWidget && element.enabled != false)
        .toList()
        .cast<FormWidget>();
    //unfocus to filtred
    for (var element in filtred) {
      element.focusNode?.unfocus();
    }
    if (filtred.last == field) {
      if (widget.continueOnLast) widget.onSubmit();
    } else {
      filtred[filtred.indexOf(field) + 1].focusNode?.requestFocus();
    }
  }

  List<Widget> _filter() {
    List<Widget> ignore = [];
    return items.map((field) {
      if (field is FormWidget) {
        if (!itemsAssigned.contains(field)) {
          field.focusNode = FocusNode();
          Function(String value)? copy = field.onFieldSubmitted;
          field.onFieldSubmitted = (value) {
            if (copy != null) copy(value);
            _handleNextFocus(field);
          };
          itemsAssigned.add(field);
        } else {}
        if (ignore.contains(field)) return Container();
        if (field.twoInLine) {
          if (items.last != field) {
            ignore.add(items[items.indexOf(field) + 1]);
          }
          return Row(
            children: [
              Expanded(
                child: field,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: items.last != field
                    ? widget.formWidgets[items.indexOf(field) + 1]
                    : Container(),
              ),
            ],
          );
        }
      }
      return field;
    }).toList();
  }

  Map<String, dynamic> prev = {};

  @override
  Widget build(BuildContext context) {
    _refill();
    return Column(children: render);
  }
}
