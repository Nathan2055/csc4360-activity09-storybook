import 'package:flutter/material.dart';
import 'package:myapp/models/story.dart';
import 'package:myapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Story story = Story(
      1,
      'Axe Murder Hollow',
      'A couple stranded in a storm discover they are not alone...',
      '''Susan and Ned were driving through a wooded, empty section of highway. Lightning flashed, thunder roared, the sky went dark in the torrential downpour.
"We’d better stop," said Susan. Ned nodded. He hit the brakes and the car slid off the road, coming to a halt at the bottom of an incline.
Shaken, Ned checked on Susan, then stepped out into the storm to inspect the car. Minutes later he jumped back in, drenched. "We’re stuck in mud. I’ll have to go for help. Lock the doors until I get back."
Outside, Susan heard a shriek, a thump, and a strange gurgling noise. Then—silence. She waited, trembling. Bump. Bump. Bump. A soft sound, like something swaying in the wind.
Suddenly, bright light flooded the car and an official-sounding voice ordered her out. As she stepped into the rain, her eyes adjusted to the light—and she saw Ned hanging upside down from the tree beside the car, throat cut so deep he was nearly decapitated. His body swung gently, thumping the trunk. Bump. Bump. Bump.
She stumbled toward the light—only to realize it wasn’t a flashlight. A glowing figure stood there, smiling, a very real axe in his hand.''',
    );

    return MaterialApp(
      title: 'Halloween Story Book',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepOrange,
          secondary: Colors.orangeAccent,
          surface: Color(0xFF121212),
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF0E0E0E),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.orange,
        ),
        cardColor: const Color(0xAA1E1E1E),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(story: story),
    );
  }
}
