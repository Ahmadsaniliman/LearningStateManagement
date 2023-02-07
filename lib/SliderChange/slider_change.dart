import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;

  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          notifier: sliderData,
        );

  static double of(context) {
    return context
            .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
            ?.notifier
            ?.value ??
        0.0;
  }
}

class SliderChangePage extends StatefulWidget {
  const SliderChangePage({Key? key}) : super(key: key);

  @override
  State<SliderChangePage> createState() => _SliderChangePageState();
}

class _SliderChangePageState extends State<SliderChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Change'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Column(
          children: [
            Slider(
              value: 0.0,
              onChanged: (value) {},
            ),
            Row(
              children: [
                Container(
                  height: 100.0,
                ),
                Container(
                  height: 100.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
