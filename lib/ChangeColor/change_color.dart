// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:math';

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorsWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

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

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    Key? key,
    required this.color,
  }) : super(key: key);
  final AvailableColors color;

  @override
  Widget build(BuildContext context) {
    final provider = AvailableColorsWidget.of(
      context,
      color,
    );
    return Container(
      height: 100.0,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

class InheritedModelHomePage extends StatefulWidget {
  const InheritedModelHomePage({Key? key}) : super(key: key);

  @override
  _InheritedModelHomePageState createState() => _InheritedModelHomePageState();
}

class _InheritedModelHomePageState extends State<InheritedModelHomePage> {
  @override
  Widget build(BuildContext context) {
    var _color1 = Colors.blue;
    var _color2 = Colors.green;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Changer'),
      ),
      body: AvailableColorsWidget(
        color1: _color1,
        color2: _color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      //   _color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      //   _color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color2'),
                ),
              ],
            ),
            const ColorWidget(
              color: AvailableColors.one,
            ),
            const ColorWidget(
              color: AvailableColors.two,
            ),
          ],
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
  Colors.brown,
  Colors.cyan,
  Colors.pink,
  Colors.black,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}
