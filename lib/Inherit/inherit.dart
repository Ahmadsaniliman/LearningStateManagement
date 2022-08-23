import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateTime;
  Future<String> getDateTime() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => DateTime.now().toIso8601String(),
    );
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;

  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : uuid = const Uuid().v4(),
        super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  static ApiProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>();
  }
}

class InheHomePage extends StatefulWidget {
  const InheHomePage({Key? key}) : super(key: key);

  @override
  State<InheHomePage> createState() => _InheHomePageState();
}

class _InheHomePageState extends State<InheHomePage> {
  @override
  Widget build(BuildContext context) {
    // String? title = 'tap the Screen';
    ValueKey _text = const ValueKey<String?>(null);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApiProvider.of(context)!.api.dateTime ?? '',
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final api = ApiProvider.of(context)!.api;
            final dateAndTime = await api.getDateTime();
            setState(() {
              _text = ValueKey(dateAndTime);
            });
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.green,
            ),
            child: Center(
              child: DateTimeWidget(
                key: _text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ApiProvider.of(context)!.api.dateTime ?? 'Tap on the screen',
    );
  }
}
