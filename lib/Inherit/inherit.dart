import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateAndTime;

  Future<String> getTimeAndDate() {
    return Future.delayed(
            const Duration(seconds: 4), () => DateTime.now().toIso8601String())
        .then((value) {
      dateAndTime = value;
      return value;
    });
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String id;

  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : id = const Uuid().v4(),
        super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return id != oldWidget.id;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class DateAndTimeWidget extends StatelessWidget {
  const DateAndTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'Tap On The Screen');
  }
}

class HomepagetimeAndDate extends StatefulWidget {
  const HomepagetimeAndDate({Key? key}) : super(key: key);

  @override
  State<HomepagetimeAndDate> createState() => _HomepagetimeAndDateState();
}

class _HomepagetimeAndDateState extends State<HomepagetimeAndDate> {
  final ValueKey _textValue = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApiProvider.of(context).api.dateAndTime ?? '',
        ),
      ),
      body: GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: DateAndTimeWidget(key: _textValue),
        ),
        onTap: () {
          final api = ApiProvider.of(context).api;
          final dateAndTime = api.dateAndTime;
          ValueKey(dateAndTime);
        },
      ),
    );
  }
}
