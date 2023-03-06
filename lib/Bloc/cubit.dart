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

class CubitNames extends Cubit<String?> {
  CubitNames() : super(null);

  void pickRandomName() => emit(names.getRandomName());
}

class NameCubitHomePage extends StatefulWidget {
  const NameCubitHomePage({Key? key}) : super(key: key);

  @override
  State<NameCubitHomePage> createState() => _NameCubitHomePageState();
}

class _NameCubitHomePageState extends State<NameCubitHomePage> {
  late final CubitNames cubit;

  @override
  void initState() {
    super.initState();
    cubit = CubitNames();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cubit Home'),
        ),
        body: StreamBuilder(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = TextButton(
              onPressed: () {},
              child: const Text('Pick a random name'),
            );

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;

              case ConnectionState.waiting:
                return button;

              case ConnectionState.active:
                return Column(
                  children: [
                    Text('${snapshot.data ?? ''}'),
                    button,
                  ],
                );

              case ConnectionState.done:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}
