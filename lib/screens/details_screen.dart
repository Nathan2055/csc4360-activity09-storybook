import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:just_audio/just_audio.dart';

class DetailsScreen extends StatelessWidget {
  final Recipe recipe;

  DetailsScreen({super.key, required this.recipe});

  AudioPlayer player1 = AudioPlayer();

  void startAudio() {
    debugPrint('Ran startAudio');
    player1.setAsset('sounds/dramatic-organ-a.wav');
    player1.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton(
                onPressed: startAudio,
                child: const Icon(Icons.play_arrow),
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(recipe.ingredients),
              const SizedBox(height: 24),
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(recipe.instructions),
            ],
          ),
        ),
      ),
    );
  }
}
