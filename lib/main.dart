import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/services/firebase_api.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/joke_provider.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/screens/home_screen.dart';
import 'package:jokes_app/screens/random_joke_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jokes App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.orange),
          cardColor: Colors.orange[50],
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black), // Replaces bodyText2
            titleLarge: TextStyle(color: Colors.green[800]), // Replaces headline6
          ),
        ),
        home: const HomeScreen(),
        routes: {
          RandomJokeScreen.route: (context) => const RandomJokeScreen(),
        }
      ),
    );
  }
}
