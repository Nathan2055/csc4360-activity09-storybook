import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const HomeScreen({super.key, required this.recipes});

  String _truncate(int cutoff, String value) {
    if (value.length <= cutoff) return value;
    return '${value.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Book')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(_truncate(20, recipe.name)),
              subtitle: Text(_truncate(25, recipe.ingredients)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
