import 'package:flutter/material.dart';

class AutoCompleteWidget extends FormField<String> {
  final List<String> options;
  final String? defaultValue;
  final Function(dynamic value)? onChange;
  final bool forcedToComplete;

  AutoCompleteWidget({
    super.key,
    super.enabled = true,
    super.validator,
    this.onChange,
    this.defaultValue,
    this.forcedToComplete = false,
    required this.options,
  }) : super(builder: (FormFieldState<String> state) {
          return Autocomplete<String>(
            initialValue: TextEditingValue(text: defaultValue ?? ''),
            optionsBuilder: (TextEditingValue textEditingValue) {
              onChange?.call(textEditingValue.text);
              state.didChange(null);
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return options.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              state.didChange(selection);
            },
          );
        });
}
