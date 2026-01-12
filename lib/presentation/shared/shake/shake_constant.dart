import 'dart:ui';

abstract class ShakeConstant {
  final List<int> interval;

  final List<Offset> translate;

  final List<double> rotate;

  final List<double> opacity;

  final Duration duration;

  ShakeConstant({
    required this.interval,
    required this.translate,
    required this.rotate,
    required this.opacity,
    this.duration = const Duration(milliseconds: 100),
  }) : assert(interval.isEmpty || interval.length == 1 || interval.length > 1),
       assert(rotate.isEmpty || rotate.length == 1 || rotate.length > 1),
       assert(opacity.isEmpty || opacity.length == 1 || opacity.length > 1),
       assert(
         translate.isEmpty || translate.length == 1 || translate.length > 1,
       );
}


