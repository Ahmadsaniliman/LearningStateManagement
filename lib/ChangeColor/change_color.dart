import 'package:flutter/material.dart';
import 'dart:math';

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel {
  final AvailableColors color1;
  final AvailableColors color2;

  const AvailableColorsWidget({
    Key? key,
    required child,
    required this.color1,
    required this.color2,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(
    covariant AvailableColorsWidget oldWidget,
  ) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set dependencies,
  ) {
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

final colors = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.brown,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() {
    return elementAt(
      Random().nextInt(length),
    );
  }
}
