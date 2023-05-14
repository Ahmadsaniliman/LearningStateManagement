import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function();

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? _controller;

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withAlpha(155),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8.toDouble(),
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    StreamBuilder<String>(
                      stream: _text.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    state.insert(overlay);

    return LoadingScreenController(close: () {
      return true;
    }, update: () {
      return false;
    });
  }
}

class Lkkkkk extends StatelessWidget {
  const Lkkkkk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
