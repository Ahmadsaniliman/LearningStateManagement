import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management Demo',
      theme: ThemeData(),
      // home: BlocProvider(
      //   create: (_) => PersonBloc(),
      //   child: const BlocHomePage(),
      // ),
      //   routes: {
      //     "/new-Contact-Route": (context) => const NewContactView(),
      //     "/new-Route": (context) => const NewBreadCrumbPage(),
      //   },
    );
  }
}
