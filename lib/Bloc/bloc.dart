import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

enum PersonUrl { person1, person2 }

// extension GetRandomName on PersonUrl {
//     String get getUrl(String url) {
//         switch(this) {
//           case PersonUrl.person1:
//             // TODO: Handle this case.
//             break;
//           case PersonUrl.person2:
//             // TODO: Handle this case.
//             break;
//         }
//     }
// }

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class PersonLoadAction implements LoadAction {}

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSizeHeight = MediaQuery.of(context).size.height;
    var screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: Center(
        child: Container(
          height: screenSizeHeight * 250,
          width: screenSizeWidth * 250,
          color: Colors.green,
        ),
      ),
    );
  }
}
