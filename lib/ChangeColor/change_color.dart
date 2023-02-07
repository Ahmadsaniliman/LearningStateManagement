import 'package:flutter/material.dart';
import 'dart:math';

enum AvailableColors { one, two }

final colors = [
  Colors.green,
  Colors.blue,
  Colors.brown,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.orange,
];

extension GetRandomColor<T> on Iterable<T> {
  T getRandom() => elementAt(
        Random().nextInt(length),
      );
}

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

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
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

class AvailableColorWidget extends StatelessWidget {
  const AvailableColorWidget({
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
      width: double.infinity,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

class AvailableColorPage extends StatefulWidget {
  const AvailableColorPage({Key? key}) : super(key: key);

  @override
  State<AvailableColorPage> createState() => _AvailableColorPageState();
}

class _AvailableColorPageState extends State<AvailableColorPage> {
  @override
  Widget build(BuildContext context) {
    var color1 = Colors.green;
    var color2 = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ('Change Color'),
        ),
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
                      color1 = colors.getRandom();
                    });
                  },
                  child: const Text('Change color1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandom();
                    });
                  },
                  child: const Text('Change color2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
