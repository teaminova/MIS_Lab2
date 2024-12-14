import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_type.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/joke_type_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    loadJokeTypes();
  }

  void loadJokeTypes() async {
    final types = await ApiService.getJokeTypes();
    setState(() {
      jokeTypes = types.map((type) => JokeType(type: type)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () => Navigator.pushNamed(context, '/randomJoke'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return JokeTypeCard(type: jokeTypes[index].type);
        },
      ),
    );
  }
}
