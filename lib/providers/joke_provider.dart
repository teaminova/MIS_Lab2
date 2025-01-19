import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokeProvider with ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  JokeProvider() {
    fetchFavorites();
    fetchJokeTypes();
  }

  final List<Joke> _favorites = [];
  bool isLoading = true;

  List<Joke> get favorites => _favorites;
  List<String> _jokeTypes = [];
  List<String> get jokeTypes => _jokeTypes;
  List<Joke> _jokesByType = [];
  List<Joke> get jokesByType => _jokesByType;
  Joke? _randomJoke;
  Joke? get randomJoke => _randomJoke;

  Future<void> fetchJokesByType(String type) async {
    isLoading = true;
    notifyListeners();
    try {
      _jokesByType = await ApiService.getJokesByType(type);
      for (var joke in _jokesByType) {
        joke.isFavorite = _favorites.any((fav) => fav.setup == joke.setup);
      }
    } catch (e) {
      print('Error fetching jokes by type: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch random joke
  Future<void> fetchRandomJoke() async {
    isLoading = true;
    notifyListeners();
    try {
      _randomJoke = await ApiService.getRandomJoke();
    } catch (e) {
      print('Error fetching random joke: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch all joke types
  Future<void> fetchJokeTypes() async {
    try {
      _jokeTypes = await ApiService.getJokeTypes();
    } catch (e) {
      print('Error fetching joke types: $e');
    }
    notifyListeners();
  }

  // Fetch favorites
  Future<void> fetchFavorites() async {
    try {
      final snapshot = await _firestore.collection('favorites').get();
      _favorites.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        _favorites.add(
          Joke(
            setup: data['setup'],
            punchline: data['punchline'],
            type: data['type'],
            isFavorite: true,
          ),
        );
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // Toggle favorite
  Future<void> toggleFavorite(Joke joke) async {
    bool isFavoriteNow = _favorites.any((fav) => fav.setup == joke.setup);

    if (isFavoriteNow) {

      _favorites.removeWhere((fav) => fav.setup == joke.setup);
      try {
        final snapshot = await _firestore
            .collection('favorites')
            .where('setup', isEqualTo: joke.setup)
            .get();
        for (var doc in snapshot.docs) {
          await _firestore.collection('favorites').doc(doc.id).delete();
        }
      } catch (e) {
        print('Error removing joke from favorites: $e');
      }
    } else {
      // Add to favorites
      _favorites.add(joke);
      try {
        await _firestore.collection('favorites').add(joke.toJson());
      } catch (e) {
        print('Error adding joke to favorites: $e');
      }
    }
    joke.isFavorite = !isFavoriteNow;
    notifyListeners();
  }
}