import 'package:flutter/material.dart';
import 'package:goodbye/goodbye.dart';
import 'package:network_manager/network_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NetworkManager>(
          create: (context) => NetworkManagerImp()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CharactersPage(),
      home: const LocationsPage(),
    );
  }
}
