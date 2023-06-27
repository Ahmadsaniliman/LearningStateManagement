import 'dart:math';
import 'package:flutter/material.dart';

enum AvailableColor { one, two }

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

class AvailableColorsWidget extends InheritedModel<AvailableColor> {
  final AvailableColor color1;
  final AvailableColor color2;

  AvailableColorsWidget({
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
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel<AvailableColor> oldWidget,
      Set<AvailableColor> dependencies) {
    // TODO: implement updateShouldNotifyDependent
    throw UnimplementedError();
  }
}
