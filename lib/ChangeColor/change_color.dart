import 'dart:math';
import 'package:flutter/material.dart';

final colors = [
  Colors.green,
  Colors.blue,
  Colors.brown,
  Colors.red,
  Colors.black,
  Colors.cyan,
  Colors.purple,
];

extension GetElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

enum AvailableColor { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColor> {
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
    AvailableColor aspect,
  ) =>
      InheritedModel.inheritFrom<AvailableColorsWidget>(
        context,
        aspect: aspect,
      )!;

  @override
  bool updateShouldNotify(
    covariant AvailableColorsWidget oldWidget,
  ) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<AvailableColor> dependencies,
  ) {
    if (dependencies.contains(AvailableColor.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColor.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({Key? key, required this.color}) : super(key: key);
  final AvailableColor color;

  @override
  Widget build(BuildContext context) {
    final provider = AvailableColorsWidget.of(
      context,
      color,
    );
    return Container(
      height: 100.0,
      color: color == AvailableColor.one ? provider.color1 : provider.color2,
    );
  }
}

class AvailableColorsWidgetHomePage extends StatefulWidget {
  const AvailableColorsWidgetHomePage({Key? key}) : super(key: key);

  @override
  State<AvailableColorsWidgetHomePage> createState() =>
      _AvailableColorsWidgetHomePageState();
}

class _AvailableColorsWidgetHomePageState
    extends State<AvailableColorsWidgetHomePage> {
  var color1 = Colors.green;
  var color2 = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Color'),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                //   color1 = colors.getRandomElement();
                });
              },
              child: const Text('Change Color1'),
            ),
            TextButton(
              onPressed: () {
                // color2 = colors.getRandomElement();
              },
              child: const Text('Change Color2'),
            ),
            const ColorsWidget(color: AvailableColor.one),
            const ColorsWidget(color: AvailableColor.two),
          ],
        ),
      ),
    );
  }
}
