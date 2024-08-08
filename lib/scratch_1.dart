// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
//
// class TreasureHuntScreen extends StatefulWidget {
//   const TreasureHuntScreen({super.key});
//
//   @override
//   _TreasureHuntScreenState createState() => _TreasureHuntScreenState();
// }
//
// class _TreasureHuntScreenState extends State<TreasureHuntScreen> {
//   ArCoreController? arCoreController;
//   AudioPlayer audioPlayer = AudioPlayer();
//   int score = 0;
//   List<Map<String, dynamic>> treasures = [
//     {
//       'position': vector.Vector3(0, 0, -1),
//       'collected': false,
//       'clue': 'Find the treasure in front of you!'
//     },
//     {
//       'position': vector.Vector3(1, 0, -2),
//       'collected': false,
//       'clue': 'Look to your right for the next treasure!'
//     },
//     {
//       'position': vector.Vector3(-1, 0, -2),
//       'collected': false,
//       'clue': 'Look to your left for another treasure!'
//     },
//   ];
//
//   @override
//   void dispose() {
//     arCoreController?.dispose();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AR Treasure Hunt'),
//       ),
//       body: Stack(
//         children: [
//           ArCoreView(
//             onArCoreViewCreated: _onArCoreViewCreated,
//             enableTapRecognizer: true,
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Score: $score',
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Clue: ${getCurrentClue()}',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     arCoreController?.onNodeTap = (name) => _onTap(name);
//     _addTreasures();
//   }
//
//   void _addTreasures() {
//     for (var i = 0; i < treasures.length; i++) {
//       final material = ArCoreMaterial(
//         color: Colors.yellow,
//         metallic: 1.0,
//       );
//
//       final sphere = ArCoreSphere(
//         materials: [material],
//         radius: 0.1,
//       );
//
//       final node = ArCoreNode(
//         shape: sphere,
//         position: treasures[i]['position'],
//         name: 'treasure_$i',
//       );
//
//       arCoreController?.addArCoreNode(node);
//     }
//   }
//
//   String getCurrentClue() {
//     for (var treasure in treasures) {
//       if (!treasure['collected']) {
//         return treasure['clue'];
//       }
//     }
//     return 'All treasures collected!';
//   }
//
//   void _onTap(String name) {
//     setState(() {
//       final index = int.parse(name.split('_')[1]);
//       if (!treasures[index]['collected']) {
//         treasures[index]['collected'] = true;
//         score += 1;
//         _playSound();
//
//         arCoreController?.removeNode(nodeName: name);
//       }
//     });
//   }
//
//   void _playSound() async {
//     await audioPlayer.play(AssetSource('audio/collect.mp3'));
//   }
// }
