import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/joke_card.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke randomJoke = Joke(setup: "", punchline: "");

  @override
  void initState() {
    super.initState();
    loadRandomJoke();
  }

  void loadRandomJoke() async {
    final joke = await ApiService.getRandomJoke();
    setState(() {
      randomJoke = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke')),
      body: Center(
        child: randomJoke == null
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              JokeCard(joke: randomJoke)
            ],
          ),
        ),
      ),
    );
  }
}
