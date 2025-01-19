import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/joke_card.dart';

import 'package:provider/provider.dart';
import '../providers/joke_provider.dart';
import 'favorite_jokes_screen.dart';

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

class JokeListScreen extends StatelessWidget {
  final String type;

  const JokeListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Provider.of<JokeProvider>(context, listen: false).fetchJokesByType(type);

    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalize(type)} Jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoriteJokesScreen()),
            ),
          ),
        ],
      ),
      body: Consumer<JokeProvider>(
        builder: (context, provider, _) {
          return provider.isLoading ?
              const Center(child: CircularProgressIndicator())
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: provider.jokesByType.length,
            itemBuilder: (context, index) {
              final joke = provider.jokesByType[index];
              return JokeCard(
                joke: joke,
                onPressed: () {
                  Provider.of<JokeProvider>(context,
                    listen: false)
                    .toggleFavorite(joke);
                },
              );
            },
          );
        },
      ),
    );
  }

}
