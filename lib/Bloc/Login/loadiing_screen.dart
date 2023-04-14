import 'package:flutter/foundation.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function();

@immutable
class LoadinScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadinScreenController({
    required this.close,
    required this.update,
  });
}
