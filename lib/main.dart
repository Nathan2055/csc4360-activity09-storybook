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
    final List<Story> sampleStories = const [
      Story(
        1,
        'Midnight at Hollow Hill',
        'A dare leads to a midnight visit to the haunted hill...',
        'They said no one ever returned after hearing the bell at midnight. But when the wind carried that distant chime, I realized the bell wasn\'t ringing from the hill at all—it was right behind me.',
      ),
      Story(
        2,
        'The Lantern in the Window',
        'Every Halloween, a lantern appears in the old manor...',
        'Grandmother said the lantern was to guide lost souls home. I only understood when I saw my reflection in the glass—faint, transparent, and smiling back from the other side.',
      ),
      Story(
        3,
        'Whispers in the Cornfield',
        'At dusk, the corn begins to whisper secrets...',
        'The farmer never believed the whispers—until he found footprints circling his house, made of corn husks and ash, stopping only at his bedroom door.',
      ),
    ];

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
      home: HomeScreen(stories: sampleStories),
    );
  }
}
