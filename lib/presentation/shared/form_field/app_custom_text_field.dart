import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppCustomTextField extends ConsumerStatefulWidget {
  const AppCustomTextField({
    super.key,
    this.title,
    this.textInputType = TextInputType.text,
    this.hintText,
    this.onChanged,
    this.errorText,
    this.inputFormatters,
    this.controller,
    this.borderColor,
    this.fillColor,
    this.fontColor,
    this.validator,
    this.onTapOutside,
    this.readOnly = false,
    required this.shake,
    this.textInputAction,
    this.onSubmitted,
  });

  final String? title;
  final String? hintText;
  final String? errorText;
  final Color? borderColor;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? fontColor;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final bool shake;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  @override
  ConsumerState<AppCustomTextField> createState() => _AppCustomTextFieldState();
}

class _AppCustomTextFieldState extends ConsumerState<AppCustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTapOutside:
              widget.onTapOutside ??
              (event) {
                FocusScope.of(context).unfocus();
              },
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly,
          validator: widget.validator,
          style: TextStyle(
            color: widget.fontColor ?? Colors.black,
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Rubik',
            ),
            filled: true,
            fillColor:
                widget.fillColor ?? Theme.of(context).colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    widget.borderColor ?? Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    widget.borderColor ?? Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 14,
              fontFamily: 'Rubik',
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
