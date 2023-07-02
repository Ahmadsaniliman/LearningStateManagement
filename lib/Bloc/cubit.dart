import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const names = [
  'Muhammad',
  'Ahmad',
  'Sani',
  'Liman',
  'Sweety',
  'Muhammad',
  'Sani',
  'Liman',
];

extension RandomNames<T> on Iterable<T> {
  T getRandomNames() => elementAt(
        Random().nextInt(length),
      );
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(
        names.getRandomNames(),
      );
}

class CubitHomePage extends StatefulWidget {
  const CubitHomePage({Key? key}) : super(key: key);

  @override
  State<CubitHomePage> createState() => _CubitHomePageState();
}

class _CubitHomePageState extends State<CubitHomePage> {
  late final NamesCubit namesCubit;

  @override
  void initState() {
    namesCubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    namesCubit.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
