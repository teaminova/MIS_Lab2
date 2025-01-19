import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_type.dart';
import 'package:jokes_app/screens/random_joke_screen.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/joke_type_card.dart';

import '../models/joke.dart';
import 'package:provider/provider.dart';
import '../providers/joke_provider.dart';
import 'favorite_jokes_screen.dart';
import 'joke_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<JokeProvider>(context, listen: false).fetchJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const RandomJokeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoriteJokesScreen()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: provider.jokeTypes.length,
        itemBuilder: (context, index) {
          final type = provider.jokeTypes[index];
          return JokeTypeCard(
            type: type,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JokeListScreen(type: type),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
