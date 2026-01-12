import 'dart:ui';

import 'shake_constant.dart';

class SmoothShakeConstant implements ShakeConstant {
  @override
  List<int> get interval => [2];

  @override
  List<double> get opacity => const [];

  @override
  List<double> get rotate => const [0, -0.05, 0.05, 0];

  @override
  List<Offset> get translate => const [
    Offset(0, 0),
    Offset(-3, 0),
    Offset(3, 0),
    Offset(0, 0),
  ];

  @override
  Duration get duration => const Duration(milliseconds: 250);
}

class MediumShakeConstant implements ShakeConstant {
  @override
  List<int> get interval => [2];

  @override
  List<double> get opacity => const [];

  @override
  List<double> get rotate => const [0, -0.2, 0.2, -0.15, 0.15, -0.1, 0.1, 0];

  @override
  List<Offset> get translate => const [
    Offset(0, 0),
    Offset(-3, 0),
    Offset(3, 0),
    Offset(-2, 0),
    Offset(2, 0),
    Offset(-1, 0),
    Offset(1, 0),
    Offset(0, 0),
  ];

  @override
  Duration get duration => const Duration(milliseconds: 300);
}

class SmoothShakeVerticalConstant implements ShakeConstant {
  @override
  List<int> get interval => [1];

  @override
  List<double> get opacity => const [];

  @override
  List<double> get rotate => const [0, -0.1, 0.1, -0.1, 0.1, -0.1, 0.1, 0];

  @override
  List<Offset> get translate => const [
    Offset(0, 0),
    Offset(0, -2),
    Offset(0, 2),
    Offset(0, -1.5),
    Offset(0, 1.5),
    Offset(0, -1),
    Offset(0, 1),
    Offset(0, 0),
  ];

  @override
  Duration get duration => const Duration(milliseconds: 400);
}

class CustomShakeConstant implements ShakeConstant {
  final double intensity;
  final int steps;
  final int intervalMs;
  final int durationMs;
  final bool verticalShake;

  const CustomShakeConstant({
    this.intensity = 2.0,
    this.steps = 6,
    this.intervalMs = 1,
    this.durationMs = 400,
    this.verticalShake = false,
  });

  @override
  List<int> get interval => [intervalMs];

  @override
  List<double> get opacity => const [];

  @override
  List<double> get rotate {
    List<double> rotations = [0];
    double maxRotation = intensity * 0.1;

    for (int i = 1; i <= steps; i++) {
      double progress = i / steps;
      double amplitude = maxRotation * (1 - progress);
      rotations.add(i.isEven ? amplitude : -amplitude);
    }
    rotations.add(0);
    return rotations;
  }

  @override
  List<Offset> get translate {
    List<Offset> translations = [const Offset(0, 0)];

    for (int i = 1; i <= steps; i++) {
      double progress = i / steps;
      double amplitude = intensity * (1 - progress);

      if (verticalShake) {
        translations.add(Offset(0, i.isEven ? amplitude : -amplitude));
      } else {
        translations.add(Offset(i.isEven ? amplitude : -amplitude, 0));
      }
    }
    translations.add(const Offset(0, 0));
    return translations;
  }

  @override
  Duration get duration => Duration(milliseconds: durationMs);
}
