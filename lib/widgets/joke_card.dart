import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              joke.setup,
              style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
                joke.punchline,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
