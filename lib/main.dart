import 'package:flutter/material.dart';
import 'package:jokes_app/screens/home_screen.dart';
import 'package:jokes_app/screens/joke_list_screen.dart';
import 'package:jokes_app/screens/random_joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jokeList': (context) => const JokeListScreen(),
        '/randomJoke': (context) => const RandomJokeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.orange),
        cardColor: Colors.orange[50],
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // Replaces bodyText2
          titleLarge: TextStyle(color: Colors.green[800]), // Replaces headline6
        ),
      ),
    );
  }
}
