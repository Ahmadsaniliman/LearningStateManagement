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
      body: SliderInheriedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider(
                value: 0.0,
                onChanged: (value) {
                  sliderData.value = value;
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: SliderInheriedNotifier.of(context),
                      child: Container(
                        height: 150,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: SliderInheriedNotifier.of(context),
                      child: Container(
                        height: 150,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
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

class SliderInheriedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheriedNotifier({
    Key? key,
    required Widget child,
    required SliderData sliderData,
  }) : super(
          key: key,
          child: child,
          notifier: sliderData,
        );

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<SliderInheriedNotifier>()
            ?.notifier
            ?._value ??
        0.0;
  }
}

final sliderData = SliderData();
