import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const names = [
  'Muhammad',
  'Ahmad',
  'Sani',
  'Liman',
  'Sweety',
];

extension GetRandomNames<T> on Iterable<T> {
  T getRandomName() => elementAt(Random().nextInt(length));
}

class CubitName extends Cubit<String?> {
  CubitName() : super(null);
}
