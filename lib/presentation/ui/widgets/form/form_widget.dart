import 'package:country_code_picker/country_code_picker.dart';
import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/date_picker.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/models/select_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'validators.dart';

// ignore: must_be_immutable
enum FormType {
  double,
  number,
  text,
  phone,
  email,
  textarea,
  password,
  dial,
  date,
}

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  final FormType type;
  final int? minLength;
  final int? maxLength;
  final int? minValue;
  final int? maxValue;
  final int? minArrayLength;
  final bool? required;
  final DateTime? minDate;
  final String? matchFieldName;
  final String? matchFieldKey;
  final String text;
  final bool outlined;
  final String keyName;
  final String? hint;
  final bool twoInLine;
  final Function(String word, int page, int itemsPerPage)? onSearch;
  Map<String, dynamic> values;
  final bool other;
  final bool enabled;
  final dynamic defaultValue;
  final Function(dynamic value)? onChange;
  final List<SelectItem>? options;
  final bool obscureText;
  FocusNode? focusNode;
  void Function(String value)? onFieldSubmitted;
  final Widget? prefixIcon;
  final List<RegexFormError>? regexs;
  final bool? atLeastOneLowercase, atLeastOneUppercase, atLeastOneNumber;
  final EdgeInsetsGeometry? padding;
  final bool? notShowOptional;
  final int? maxErrorLines;
  final Function(bool enabled)? onTap;

  FormWidget({
    super.key,
    required this.text,
    this.padding,
    required this.keyName,
    this.type = FormType.text,
    this.required = false,
    this.other = false,
    this.onSearch,
    this.enabled = true,
    this.minLength,
    this.outlined = false,
    this.maxLength,
    required this.values,
    this.minValue,
    this.maxValue,
    this.hint,
    this.defaultValue,
    this.minArrayLength,
    this.matchFieldKey,
    this.minDate,
    this.obscureText = false,
    this.matchFieldName,
    this.onChange,
    this.twoInLine = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.regexs,
    this.maxErrorLines = 2,
    this.atLeastOneLowercase,
    this.atLeastOneNumber,
    this.atLeastOneUppercase,
    this.notShowOptional = false,
    this.onTap,
    this.options,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _diposed = false;
  late LocalizationState localization;

  String _addOptionalText(String? text, bool? isOptional) {
    if (text == null || text.isEmpty) return text ?? "";
    return text +
        (isOptional != true && widget.notShowOptional != true
            ? (" (${localization.translate(KeyWordsLocalization.Optional)})")
            : "");
  }

  @override
  void initState() {
    //add listener to viewModel in widget.values
    super.initState();
  }

  @override
  void dispose() {
    _diposed = true;
    _controller.dispose();
    super.dispose();
  }

  void _loadController() {
    if (!mounted || _diposed) return;
    String _text;
    _text =
        widget.values[widget.keyName]?.toString() ??
        widget.defaultValue?.toString() ??
        '';
    if (_controller.text != _text && mounted) {
      _controller.text = _text;
    }
  }

  TextInputType getInputType() {
    switch (widget.type) {
      case FormType.text:
        return TextInputType.text;
      case FormType.number:
        return TextInputType.number;
      case FormType.double:
        return TextInputType.numberWithOptions(decimal: true);
      case FormType.phone:
        return TextInputType.phone;
      case FormType.email:
        return TextInputType.emailAddress;
      case FormType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    if (mounted) {
      _loadController();
    }
    localization = Provider.of<LocalizationState>(context);

    switch (widget.type) {
      case FormType.dial:
        if (widget.defaultValue == null &&
            widget.values[widget.keyName] == null) {
          widget.values[widget.keyName] = "+57";
        }
        return Container(
          padding: widget.padding ?? EdgeInsets.only(top: 3, bottom: 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CountryCodePicker(
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: widget.values[widget.keyName] ?? 'CO',
            enabled: widget.enabled,
            favorite: ['+57', 'CO'],
            // optional. Shows only country name and flag
            showCountryOnly: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
            onInit: (val) {
              widget.values[widget.keyName] = val?.dialCode ?? 'CO';
            },
            onChanged: (val) {
              widget.values[widget.keyName] = val;
            },
          ),
        );
      case FormType.date:
        if (widget.defaultValue != null) {
          widget.values[widget.keyName] = widget.defaultValue;
        }
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: DatePicker(
            title: _addOptionalText(widget.text, widget.required),
            enabled: widget.enabled,
            validator:
                (value) => Validators.check(
                  regexs: widget.regexs,
                  isEmail: widget.type == FormType.email,
                  atLeastOneLowercase: widget.atLeastOneLowercase,
                  atLeastOneNumber: widget.atLeastOneNumber,
                  atLeastOneUppercase: widget.atLeastOneUppercase,
                  text: value,
                  type: widget.type,
                  key: widget.keyName,
                  required: widget.required ?? false,
                  fields: widget.values,
                  context: context,
                  minLength: widget.minLength,
                  maxLength: widget.maxLength,
                  minValue: widget.minValue,
                  minDate: widget.minDate,
                  maxValue: widget.maxValue,
                  matchFieldName: widget.matchFieldName,
                  matchFieldKey: widget.matchFieldKey,
                ),
            onChange: (val) {
              if (widget.type == FormType.double) {
                widget.values[widget.keyName] = val.replaceAll(',', '.');
              } else {
                widget.values[widget.keyName] = val;
              }
              widget.onFieldSubmitted?.call(val.toString());
            },
          ),
        );

      default:
        if (widget.defaultValue != null) {
          widget.values[widget.keyName] = widget.defaultValue;
        }

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: TextFormField(
            onTap: () => widget.onTap?.call(widget.enabled),
            cursorColor: Theme.of(context).primaryColor,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              hintText: widget.hint,
              labelStyle:
                  widget.enabled
                      ? Theme.of(context).inputDecorationTheme.labelStyle
                      : Theme.of(context).inputDecorationTheme.labelStyle
                          ?.copyWith(color: Theme.of(context).disabledColor),
              icon: widget.prefixIcon,
              suffixIcon:
                  widget.type == FormType.password
                      ? IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                            widget.focusNode?.requestFocus();
                          });
                        },
                      )
                      : null,
              labelText: _addOptionalText(widget.text, widget.required),
            ),
            keyboardType: getInputType(),
            controller: _controller,
            onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
            obscureText:
                ((!_passwordVisible && widget.type == FormType.password) ||
                    widget.obscureText) &&
                widget.type != FormType.textarea,
            maxLines:
                widget.type == FormType.textarea
                    ? 3
                    : (widget.obscureText ||
                        (!_passwordVisible && widget.type == FormType.password))
                    ? 1
                    : null,
            onChanged: (val) {
              dynamic value;
              if (widget.type == FormType.number) {
                value = double.tryParse(val)?.toInt();
              } else if (widget.type == FormType.double) {
                value = double.tryParse(val);
              } else {
                value = val;
              }
              widget.values[widget.keyName] = value;
              widget.onChange?.call(value);
            },
            enabled: widget.enabled,
            validator: (val) {
              return Validators.check(
                regexs: widget.regexs,
                isEmail: widget.type == FormType.email,
                atLeastOneLowercase: widget.atLeastOneLowercase,
                atLeastOneNumber: widget.atLeastOneNumber,
                atLeastOneUppercase: widget.atLeastOneUppercase,
                text: val,
                type: widget.type,
                key: widget.keyName,
                required: widget.required ?? false,
                fields: widget.values,
                context: context,
                minLength: widget.minLength,
                maxLength: widget.maxLength,
                minValue: widget.minValue,
                maxValue: widget.maxValue,
                matchFieldName: widget.matchFieldName,
                matchFieldKey: widget.matchFieldKey,
              );
            },
          ),
        );
    }
  }
}
