import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;
  final VoidCallback onTap;

  const JokeTypeCard({super.key, required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.pushNamed(context, '/jokeList', arguments: type),
      child: Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListTile(
              onTap: onTap,
              title: Text(
                type.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ),
        )
      ),
    );
  }
}
