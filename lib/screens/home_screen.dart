import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myapp/models/story.dart';
import 'package:myapp/screens/details_screen.dart';
import 'package:just_audio/just_audio.dart';

// Simple item model for the mini-game
class _SpookyItem {
  final int id;
  final bool isTarget; // the winning item
  Offset position; // pixel position inside the game area (set after layout)
  final String imageUrl; // replace with asset path later if desired
  _SpookyItem({
    required this.id,
    required this.isTarget,
    required this.position,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  final Story story;

  const HomeScreen({super.key, required this.story});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();

  // Game config
  static const double _gameHeight = 220;
  static const double _itemSize = 56; // size for images
  static const int _itemCount = 3; // exactly three items

  // Game state
  Size? _gameAreaSize; // set from LayoutBuilder
  late List<_SpookyItem> _items;
  bool _found = false;

  @override
  void initState() {
    super.initState();
    _items = _createItems();
    _playAudioBackground();
  }

  void _playAudioBackground() {
    debugPrint("ran _playAudioBackground");
    AudioPlayer player = AudioPlayer();
    player.setAsset('sounds/howling-wind.wav');
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  Future<void> _playAudio1() async {
    debugPrint("ran _playAudio1");
    AudioPlayer player = AudioPlayer();
    player.setAsset('sounds/dramatic-organ-a.wav');
    await player.play();
    await player.stop();
  }

  Future<void> _playAudio2() async {
    debugPrint("ran _playAudio2");
    AudioPlayer player = AudioPlayer();
    player.setAsset('sounds/evil-laugh-1.wav');
    await player.play();
    await player.stop();
  }

  List<_SpookyItem> _createItems() {
    // pick a random target among three
    final int targetIndex = _random.nextInt(_itemCount);
    // Placeholder images; replace imageUrl with your own assets later
    final sprites = <String>[
      'images/pumpkins-small.jpg',
      'images/pumpkins-small.jpg',
      'images/pumpkins-small.jpg',
    ];
    return List.generate(_itemCount, (i) {
      return _SpookyItem(
        id: i,
        isTarget: i == targetIndex,
        position: Offset.zero, // assigned when we know area size
        imageUrl: sprites[i],
      );
    });
  }

  void _placeItemsAtEdges() {
    if (_gameAreaSize == null) return;
    // Only place once
    if (_items.any((it) => it.position != Offset.zero)) return;

    final double w = _gameAreaSize!.width;
    final double h = _gameAreaSize!.height;

    // Positions near the edges of the top game area
    final positions = <Offset>[
      Offset(12, h * 0.35), // left edge, mid-top
      Offset((w - _itemSize) / 2, h * 0.08), // top center
      Offset(w - _itemSize - 12, h * 0.55), // right edge, a bit lower
    ];

    for (int i = 0; i < _items.length; i++) {
      _items[i].position = positions[i];
    }
  }

  void _resetGame() {
    setState(() {
      _found = false;
      _items = _createItems();
      _placeItemsAtEdges();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halloween Story Book')),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: const DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/pumpkins-big.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Dark overlay for readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          // Content: static mini-game on top, single story card below
          Positioned.fill(
            child: Column(
              children: [
                // Mini-game area (top part)
                SizedBox(
                  height: _gameHeight,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      _gameAreaSize = Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      );
                      _placeItemsAtEdges();

                      return Stack(
                        children: [
                          const Positioned(
                            left: 12,
                            top: 8,
                            child: Text(
                              'Find the glowing item',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          for (final item in _items)
                            Positioned(
                              left: item.position.dx,
                              top: item.position.dy,
                              child: GestureDetector(
                                onTap: () {
                                  if (item.isTarget) {
                                    _playAudio1();
                                    setState(() => _found = true);
                                  } else {
                                    _playAudio2();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Not the one!'),
                                      ),
                                    );
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        item.imageUrl,
                                        width: _itemSize,
                                        height: _itemSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (item.isTarget)
                                      Container(
                                        width: _itemSize + 10,
                                        height: _itemSize + 10,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orange.withOpacity(
                                                0.7,
                                              ),
                                              blurRadius: 12,
                                              spreadRadius: 1.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Single story center text (tappable)
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(story: widget.story),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.story.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to read',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_found)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.75),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.celebration,
                      size: 64,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'You Found It!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: _resetGame,
                          child: const Text('Play Again'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => setState(() => _found = false),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
