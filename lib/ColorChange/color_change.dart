import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'dart:developer' as devtool show log;

class HomeColor extends StatelessWidget {
  const HomeColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color1 = Colors.green;
    var color2 = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Color'),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}

final colors = [
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.black,
  Colors.brown,
  Colors.red,
];

enum AvailableColors { one, two }

extension RandomColors<T> on Iterable<T> {
  T getRandomColors() => elementAt(
        Random().nextInt(length),
      );
}

class AvailableColorsWidget extends InheritedModel<AvailableColorsWidget> {
  final Color color1;
  final Color color2;

  const AvailableColorsWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );
  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set dependencies,
  ) {
    if (dependencies.contains(oldWidget.color1)) {
      return true;
    }
    if (dependencies.contains(oldWidget.color2)) {
      return true;
    }
    return false;
  }

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtool.log('Color1 has rebuild');
        break;
      case AvailableColors.two:
        devtool.log('Color2 has rebuild');
        break;
    }

    final provider = AvailableColorsWidget.of(
      context,
      color,
    );
    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}
