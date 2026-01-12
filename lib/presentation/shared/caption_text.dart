import 'package:flutter/material.dart';

/// Widget de texto con estilo Caption
/// 
/// Estilo por defecto:
/// - fontFamily: 'Rubik'
/// - fontSize: 12
/// - fontWeight: FontWeight.w400
/// - color: Theme colorScheme.onSurface
class CaptionText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CaptionText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Rubik',
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        height: height,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}



