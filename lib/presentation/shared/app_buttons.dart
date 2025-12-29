import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final Widget? icon;
  final Widget? trailingIcon;
  final String? label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? iconSpacing;
  final FontWeight? fontWeight;
  final OutlinedBorder? shape;

  const CustomOutlinedButton({
    super.key,
    this.icon,
    this.trailingIcon,
    this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.iconSpacing,
    this.fontWeight,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(
          width ?? MediaQuery.of(context).size.width * 0.41,
          height ?? 40,
        ),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
        shape:
            shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: (label != null) ? (iconSpacing ?? 8.0) : 0.0,
            ),
            child: icon ?? const SizedBox.shrink(),
          ),
          if (label != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  label!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor ?? Theme.of(context).colorScheme.primary,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            ),
          trailingIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Function onPressed;
  final double? width;
  final double? height;
  final ButtonStyle? buttonStyle;

  const CustomElevatedButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.fontSize = 14.0,
    this.textAlign,
    this.backgroundColor,
    this.fontWeight,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  final FontWeight? fontWeight;
  final SvgPicture? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          disabledBackgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          textStyle: const TextStyle(fontFamily: 'Rubik'),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: textAlign ?? TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
            if (icon != null)
              Padding(padding: const EdgeInsets.only(left: 8.0), child: icon!),
          ],
        ),
      ),
    );
  }
}
