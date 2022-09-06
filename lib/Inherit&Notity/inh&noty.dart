// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ColorOpacity extends StatelessWidget {
  const ColorOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Opacity'),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              Slider(
                value: 0.0,
                onChanged: (value) {},
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

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

class SliderDataInheritedNotifier extends InheritedNotifier {
  const SliderDataInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          notifier: sliderData,
        );

  static double of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType <
            SliderDataInheritedNotifier()?.notifier?.value ??
        0.0;
  }
}

final sliderData = SliderData();
