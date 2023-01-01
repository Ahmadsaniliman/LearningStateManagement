import 'package:flutter/material.dart';
import 'dart:math';

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

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
  const ColorWidget({Key? key, required this.color}) : super(key: key);
  final AvailableColors color;
  @override
  Widget build(BuildContext context) {
    final provider = AvailableColorsWidget.of(context, color);
    return Container(
      height: 100.0,
      color: color != AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

class ColorChangeHomePage extends StatefulWidget {
  const ColorChangeHomePage({Key? key}) : super(key: key);

  @override
  _ColorChangeHomePageState createState() => _ColorChangeHomePageState();
}

class _ColorChangeHomePageState extends State<ColorChangeHomePage> {
  var color1 = Colors.green;
  var color2 = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Change'),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color2'),
                ),
              ],
            )
          ],
        ),
      ),
    );
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

class ShouldUpdateWidget extends InheritedModel {
  const ShouldUpdateWidget({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel oldWidget, Set dependencies) {
    // TODO: implement updateShouldNotifyDependent
    throw UnimplementedError();
  }
}
