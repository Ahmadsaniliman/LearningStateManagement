import 'package:flutter/material.dart';

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(newValue) {
    if (newValue != value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required Widget child,
    required SliderData sliderData,
  }) : super(
          key: key,
          notifier: sliderData,
          child: child,
        );

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

final sliderData = SliderData();

class SliderHomePage extends StatelessWidget {
  const SliderHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Change'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider(
                value: SliderInheritedNotifier.of(context),
                onChanged: (value) {
                  sliderData.value = value;
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 200.0,
                      color: Colors.green,
                    ),
                  ),
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 200.0,
                      color: Colors.blue,
                    ),
                  ),
                ].expandEqually().toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map(
        (e) => Expanded(
          child: e,
        ),
      );
}
