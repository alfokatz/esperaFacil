import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_custom_text_field.dart';

class AppFormFieldWithLabel extends StatelessWidget {
  final TextInputType textInputType;
  bool? required;
  String? title;
  final TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChanged;
  double? fontSize;
  FontWeight? fontWeight;
  double? height;
  String? fontFamily;
  String? Function(String?)? validator;
  String? errorText;
  Function(PointerDownEvent)? onTapOutside;
  final bool shake;
  String? hintText;
  TextInputAction? textInputAction;
  Function(String)? onSubmitted;

  AppFormFieldWithLabel({
    super.key,
    required this.textInputType,
    this.title,
    this.controller,
    this.inputFormatters,
    this.onChanged,
    this.required = true,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.fontFamily,
    this.validator,
    this.errorText,
    this.onTapOutside,
    required this.shake,
    this.hintText,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              if (required == true)
                Text(
                  ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontFamily: 'Rubik',
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        AppCustomTextField(
          shake: shake,
          controller: controller,
          hintText: hintText,
          textInputType: textInputType,
          fillColor: Theme.of(context).colorScheme.surface,
          fontColor: Theme.of(context).colorScheme.onSurface,
          inputFormatters: inputFormatters ?? [],
          onChanged: onChanged,
          onTapOutside:
              onTapOutside ??
              (event) => FocusManager.instance.primaryFocus?.unfocus(),
          errorText: errorText,
          borderColor: Theme.of(context).colorScheme.outline,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
