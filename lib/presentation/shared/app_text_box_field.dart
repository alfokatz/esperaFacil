import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/presentation/shared/caption_text.dart';
import 'package:template/presentation/shared/shake/shake_widget.dart';

import 'shake/shake_animation.dart';

class AppTextBox extends StatelessWidget {
  const AppTextBox({
    super.key,
    required this.label,
    this.hintText,
    this.placeholder,
    this.onChanged,
    this.errorText,
    this.controller,
    this.minLines = 4,
    this.maxLines = 8,
    this.required = false,
    this.minLength,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.onTapOutside,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.fontColor,
    this.shake = false,
  });

  final String label;
  final String? hintText;
  final String? placeholder;
  final String? errorText;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final bool required;
  final int? minLength;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final Color? fontColor;
  final bool shake;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: CaptionText(label, fontSize: 14)),
            if (required) const Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        ShakeWidget(
          autoPlay: shake,
          shakeConstant: SmoothShakeConstant(),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            onTapOutside:
                onTapOutside ?? (event) => FocusScope.of(context).unfocus(),
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            minLines: minLines,
            maxLines: maxLines,
            maxLength: maxLength,
            style: TextStyle(
              color: fontColor ?? Theme.of(context).colorScheme.onSurface,
              fontFamily: 'Rubik',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: placeholder ?? hintText,
              filled: true,
              fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.outline,
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
              errorText: errorText,
              errorStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.error,
              ),
              errorMaxLines: 2,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
