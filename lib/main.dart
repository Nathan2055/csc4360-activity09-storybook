import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => MoodModel(), child: MyApp()),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = 'Happy';
  String _currentMoodImage = 'images/emoji_happy.png';

  final String _happyMood = 'Happy';
  final String _happyMoodImage = 'images/emoji_happy.png';

  final String _sadMood = 'Sad';
  final String _sadMoodImage = 'images/emoji_sad.png';

  final String _excitedMood = 'Excited';
  final String _excitedMoodImage = 'images/emoji_excited.png';

  String get currentMood => _currentMood;
  String get currentMoodImage => _currentMoodImage;

  String get happyMood => _happyMood;
  String get happyMoodImage => _happyMoodImage;

  String get sadMood => _sadMood;
  String get sadMoodImage => _sadMoodImage;

  String get excitedMood => _excitedMood;
  String get excitedMoodImage => _excitedMoodImage;

  Color _backgroundColor = Colors.yellow;
  Color get backgroundColor => _backgroundColor;

  var _moodCounts = {'Happy': 0, 'Sad': 0, 'Excited': 0};
  Map get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = _happyMood;
    _currentMoodImage = _happyMoodImage;
    _backgroundColor = Colors.yellow;
    _moodCounts['Happy'] = _moodCounts['Happy']! + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = _sadMood;
    _currentMoodImage = _sadMoodImage;
    _backgroundColor = Colors.blue;
    _moodCounts['Sad'] = _moodCounts['Sad']! + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = _excitedMood;
    _currentMoodImage = _excitedMoodImage;
    _backgroundColor = Colors.orange;
    _moodCounts['Excited'] = _moodCounts['Excited']! + 1;
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          backgroundColor: moodModel.backgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 30),
                MoodButtons(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(moodModel.currentMood, style: TextStyle(fontSize: 100)),
            Image.asset(moodModel.currentMoodImage, width: 128, height: 128),
          ],
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setHappy();
              },
              child: Consumer<MoodModel>(
                builder: (context, moodModel, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(moodModel.happyMood),
                      Text('  '),
                      Image.asset(
                        moodModel.happyMoodImage,
                        width: 32,
                        height: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              children: [
                Text('Happy Count: '),
                Consumer<MoodModel>(
                  builder: (context, moodModel, child) {
                    return Text(moodModel.moodCounts['Happy']!.toString());
                  },
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setSad();
              },
              child: Consumer<MoodModel>(
                builder: (context, moodModel, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(moodModel.sadMood),
                      Text('  '),
                      Image.asset(
                        moodModel.sadMoodImage,
                        width: 32,
                        height: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              children: [
                Text('Sad Count: '),
                Consumer<MoodModel>(
                  builder: (context, moodModel, child) {
                    return Text(moodModel.moodCounts['Sad']!.toString());
                  },
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setExcited();
              },
              child: Consumer<MoodModel>(
                builder: (context, moodModel, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(moodModel.excitedMood),
                      Text('  '),
                      Image.asset(
                        moodModel.excitedMoodImage,
                        width: 32,
                        height: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              children: [
                Text('Excited Count: '),
                Consumer<MoodModel>(
                  builder: (context, moodModel, child) {
                    return Text(moodModel.moodCounts['Excited']!.toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
