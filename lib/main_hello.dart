import 'package:flutter/material.dart';
import 'package:network_manager/network_manager.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.HELLO;
  runApp(
    MultiProvider(
      providers: [
        Provider<NetworkManager>(
          create: (context) => NetworkManagerImp()..init(),
        ),
      ],
      child: const App(),
    ),
  );
}
