import 'package:flutter/material.dart';
import 'dart:math';

enum AvailableColors { one, two }

class AvailableColorWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant AvailableColorWidget oldWidget) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorWidget oldWidget,
    Set<AvailableColors> dependencies,
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

  static AvailableColorWidget of(
    context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorWidget>(
      context,
      aspect: aspect,
    )!;
  }
}

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  final AvailableColors color;

  @override
  Widget build(BuildContext context) {
    final provider = AvailableColorWidget.of(
      context,
      color,
    );
    return Container(
      height: 100.0,
      width: double.infinity,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

final List<Color> colors = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.red,
  Colors.brown,
  Colors.pink,
  Colors.purple,
];

extension GetRandomColor<T> on Iterable<T> {
  T getRandom() => elementAt(
        Random().nextInt(length),
      );
}
