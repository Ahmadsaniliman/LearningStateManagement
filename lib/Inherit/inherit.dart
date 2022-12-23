import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateAndTime;

  Future<String> getTimeAndDate() {
    return Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () => DateTime.now().toIso8601String(),
    ).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}

class ApiProvider extends InheritedWidget {
  final String uuid;
  final Api api;

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

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class TimeAndDateWidget extends StatelessWidget {
  const TimeAndDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(
      api.dateAndTime ?? '',
    );
  }
}

class InheritedHomePage extends StatefulWidget {
  const InheritedHomePage({Key? key}) : super(key: key);

  @override
  _InheritedHomePageState createState() => _InheritedHomePageState();
}

class _InheritedHomePageState extends State<InheritedHomePage> {
  @override
  Widget build(BuildContext context) {
    ValueKey _textValue = const ValueKey<String?>(null);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApiProvider.of(context).api.dateAndTime ?? '',
        ),
      ),
      body: GestureDetector(
        onTap: () async {
          final api = ApiProvider.of(context).api;
          final dateAndTime = await api.getTimeAndDate();
          setState(() {
            _textValue = ValueKey(dateAndTime);
          });
        },
        child: Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(_textValue.value),
        ),
      ),
    );
  }
}
