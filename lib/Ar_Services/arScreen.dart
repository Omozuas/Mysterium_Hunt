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
    _addObjects();
  }

  void _addObjects() {
    for (var cube in cubes) {
      _addCube(cube);
    }
    for (var cylinder in cylinders) {
      _addCylinder(cylinder);
    }
  }

  void _addCube(Map<String, dynamic> cube) {
    final material = ArCoreMaterial(
      color: cube['color'],
      metallic: 1.0,
    );

    final cubeShape = ArCoreCube(
      size: vector.Vector3(0.5, 0.5, 0.5),
      materials: [material],
    );

    final node = ArCoreNode(
      shape: cubeShape,
      position: cube['position'],
      name: cube['name'],
    );

    arCoreController?.addArCoreNode(node);
  }

  void _addCylinder(Map<String, dynamic> cylinder) {
    final material = ArCoreMaterial(
      color: cylinder['color'],
      metallic: 1.0,
    );

    final cylinderShape = ArCoreCylinder(
      radius: 0.3,
      height: 0.5,
      materials: [material],
    );

    final node = ArCoreNode(
      shape: cylinderShape,
      position: cylinder['position'],
      name: cylinder['name'],
    );

    arCoreController?.addArCoreNode(node);
  }

  void _onTap(String name) {
    setState(() {
      final cubeIndex = cubes.indexWhere((cube) => cube['name'] == name);
      final cylinderIndex =
          cylinders.indexWhere((cylinder) => cylinder['name'] == name);

      if (cubeIndex != -1 && !cubes[cubeIndex]['collected']) {
        cubes[cubeIndex]['collected'] = true;
        score += 1;
        _playSound();

        arCoreController?.removeNode(nodeName: name);
      } else if (cylinderIndex != -1 &&
          !cylinders[cylinderIndex]['collected']) {
        cylinders[cylinderIndex]['collected'] = true;
        score += 1;
        _playSound();

        arCoreController?.removeNode(nodeName: name);
      }
    });
  }

  void _playSound() async {
    await audioPlayer.play(AssetSource('audio/collect.mp3'));
  }
}
