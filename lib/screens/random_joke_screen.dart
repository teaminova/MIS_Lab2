import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/joke_card.dart';
import 'package:provider/provider.dart';

import '../providers/joke_provider.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});
  static const route = '/random_joke';

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  bool isLoading = true;
  String setup = "";
  String punchline = "";
  // Joke randomJoke = Joke(setup: '', punchline: '', type: '', isFavorite: false);

  @override
  void initState() {
    super.initState();
    fetchRandomJoke();
  }

  Future<void> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        setup = data['setup'];
        punchline = data['punchline'];
        isLoading = false;
      });
    } else {
      setState(() {
        setup = "Failed to load joke.";
        punchline = "";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<JokeProvider>(context, listen: false).fetchRandomJoke();

    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke')),
      body: isLoading ?
        const Center(child: CircularProgressIndicator())
          : Center(
        child:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          setup,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          punchline,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        // const SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
      // body: Consumer<JokeProvider>(
      //   builder: (context, provider, _) {
      //     final joke = provider.randomJoke;
      //     return provider.isLoading ?
      //       const Center(child: CircularProgressIndicator())
      //         : Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           JokeCard(
      //             joke: joke,
      //             onPressed: () {
      //               Provider.of<JokeProvider>(context,
      //                   listen: false)
      //                   .toggleFavorite(joke);
      //             },
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
