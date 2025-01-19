import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke.dart';
import 'package:jokes_app/widgets/joke_card.dart';

import 'package:provider/provider.dart';
import '../providers/joke_provider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Jokes')),
      body: provider.isLoading ?
          const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final joke = provider.favorites[index];
          return JokeCard(
            joke: joke,
            onPressed: () {
              Provider.of<JokeProvider>(context,
                listen: false)
                .toggleFavorite(joke);
            }, // Optional for display-only
          );
        },
      ),
    );
  }
}
