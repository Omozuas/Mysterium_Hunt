import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TreasureHuntScreen extends StatefulWidget {
  const TreasureHuntScreen({super.key});

  @override
  _TreasureHuntScreenState createState() => _TreasureHuntScreenState();
}

class _TreasureHuntScreenState extends State<TreasureHuntScreen> {
  ArCoreController? arCoreController;
  AudioPlayer audioPlayer = AudioPlayer();
  int score = 0;

  List<Map<String, dynamic>> cubes = [
    {
      "name": "Cube1",
      "position": vector.Vector3(-0.5, 0.5, -3.5),
      "color": Colors.black
    },
    {
      "name": "Cube2",
      "position": vector.Vector3(0.5, -0.5, -4.0),
      "color": Colors.red
    },
    {
      "name": "Cube3",
      "position": vector.Vector3(-1.0, -0.5, -2.5),
      "color": Colors.green
    },
    {
      "name": "Cube4",
      "position": vector.Vector3(1.0, 1.0, -3.0),
      "color": Colors.yellow
    },
  ];

  List<Map<String, dynamic>> cylinders = [
    {
      "name": "Cylinder1",
      "position": vector.Vector3(0.0, -0.5, -2.0),
      "color": Colors.blue
    },
    {
      "name": "Cylinder2",
      "position": vector.Vector3(0.5, 0.0, -3.0),
      "color": Colors.purple
    },
    {
      "name": "Cylinder3",
      "position": vector.Vector3(-1.5, 0.5, -4.0),
      "color": Colors.orange
    },
  ];

  List<Map<String, dynamic>> treasures = [];

  @override
  void initState() {
    super.initState();
    treasures = [...cubes, ...cylinders];
    for (var treasure in treasures) {
      treasure['collected'] = false;
    }
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Treasure Hunt'),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Clue: ${getCurrentClue()}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => _onTap(name);
    _addTreasures();
  }

  void _addTreasures() {
    for (var i = 0; i < treasures.length; i++) {
      final material = ArCoreMaterial(
        color: treasures[i]['color'],
      );

      final shape = treasures[i]['name'].startsWith('Cube')
          ? ArCoreCube(
              materials: [material],
              size: vector.Vector3(0.2, 0.2, 0.2),
            )
          : ArCoreCylinder(
              materials: [material],
              radius: 0.1,
              height: 0.2,
            );

      final node = ArCoreNode(
        shape: shape,
        position: treasures[i]['position'],
        name: treasures[i]['name'],
      );

      arCoreController?.addArCoreNode(node);
    }
  }

  String getCurrentClue() {
    for (var treasure in treasures) {
      if (!treasure['collected']) {
        return 'Find the ${treasure['name']}!';
      }
    }
    return 'All treasures collected!';
  }

  void _onTap(String name) {
    setState(() {
      final treasure = treasures.firstWhere((t) => t['name'] == name);
      if (!treasure['collected']) {
        treasure['collected'] = true;
        score += 1;
        _playSound();
      }
    });
  }

  void _playSound() async {
    await audioPlayer
        .play(AssetSource('audio/DXE9BCY-vibrant-game-game-touch-2.mp3'));
  }
}
