import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateAndTime;

  Future<String> getCurrentTime() => Future.delayed(
        const Duration(seconds: 2),
        () => DateTime.now().toIso8601String(),
      ).then((value) {
        dateAndTime = value;
        return value;
      });
}

// const api = const Api();

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
    return Text(
      api.dateAndTime ?? 'Tap on the screen',
    );
  }
}

class InheritedHomePage extends StatefulWidget {
  const InheritedHomePage({Key? key}) : super(key: key);

  @override
  State<InheritedHomePage> createState() => _InheritedHomePageState();
}

class _InheritedHomePageState extends State<InheritedHomePage> {
  ValueKey textKey = const ValueKey<String?>(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApiProvider.of(context).api.dateAndTime ?? '',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          final dateAndTime = ApiProvider.of(context).api;
          final datenandtime = dateAndTime.getCurrentTime();
          setState(() {
            textKey = ValueKey(datenandtime);
          });
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: DateAndTimeWidget(key: textKey),
        ),
      ),
    );
  }
}
