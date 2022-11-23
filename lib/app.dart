import 'package:flutter/material.dart';
import 'package:goodbye/goodbye.dart';
import 'package:hello/hello.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: startWidget(F.appFlavor!),
    );
  }
}

Widget startWidget(Flavor flavor) {
  switch (flavor) {
    case Flavor.HELLO:
      return const CharactersPage();
    case Flavor.GOODBYE:
      return const LocationsPage();
    default:
      return const SizedBox.shrink();
  }
}
