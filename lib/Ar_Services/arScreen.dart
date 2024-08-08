import 'dart:async';
import 'dart:math';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:vector_math/vector_math_64.dart' as vector64;

class Arscreen extends StatefulWidget {
  const Arscreen({super.key});

  @override
  State<Arscreen> createState() => _ArscreenState();
}

class _ArscreenState extends State<Arscreen> {
  ArCoreController? arCoreController;
  String? objectedSelected;
  List<ArCoreNode> nodes1 = [];
  ArCoreNode? cylinderNode;
  Timer? updateTimer;
  double rotationAngle = 0.0;
  final double distanceThreshold = 1.5; // Threshold distance for indicator
  @override
  void dispose() {
    updateTimer?.cancel();
    arCoreController?.dispose();
    super.dispose();
  }

  onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (String name) => onItemTapped(name);

    displayCube(arCoreController!);
    displayCylinde(arCoreController!);
    displayImage(arCoreController!);
    // displayEarth(arCoreController!);

    // Start periodic updates
    updateTimer =
        Timer.periodic(Duration(milliseconds: 100), (timer) => onUpdate());
  }

  displayCube(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.black,
      metallic: 2,
    );
    final cube = ArCoreCube(
        size: vector64.Vector3(0.5, 0.5, 0.5), materials: [materials]);

    final node = ArCoreNode(
        shape: cube, position: vector64.Vector3(-0.5, 0.5, -3.5), name: "cube");

    arCoreController!.addArCoreNode(node);
    nodes1.add(node);
  }

  displayCylinde(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.blue,
      reflectance: 2,
    );
    final cylinder =
        ArCoreCylinder(height: 0.4, radius: 0.5, materials: [materials]);
    // Get a random position
    final randomPosition = getRandomPosition();
    cylinderNode = ArCoreNode(
      shape: cylinder,
      position: randomPosition,
      name: 'cylinderNode',
    );

    arCoreController!.addArCoreNode(cylinderNode!);
    nodes1.add(cylinderNode!);
  }

  void displayImage(ArCoreController controller) async {
    // Load image bytes
    final ByteData imageData =
        await rootBundle.load('assets/images/spider_two.png');
    final Uint8List bytes = imageData.buffer.asUint8List();

    // Create ArCoreImage
    final arCoreImage = ArCoreImage(
      bytes: bytes,
      width: 512,
      height: 512,
    );

    // Create ArCoreNode with ArCoreImage
    final node = ArCoreNode(
      image: arCoreImage,
      position: vector64.Vector3(1.0, 0.0, -2.5),
      name: 'imageNode',
    );

    arCoreController!.addArCoreNode(node);
    nodes1.add(node);
  }

  void displayEarth(ArCoreController controller) async {
    final ByteData imageByte = await rootBundle.load('assets/images/eath.jpg');

    final materials = ArCoreMaterial(
        color: Colors.white, textureBytes: imageByte.buffer.asUint8List());
    final sphere = ArCoreSphere(
      materials: [materials],
      radius: 0.25, // Reduced size
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(-0.5, 0.5, -1.0), // Changed position
      name: 'earthNode',
    );

    arCoreController!.addArCoreNode(node);
    nodes1.add(node);
  }

  void displayAugmentedImage(ArCoreController controller) async {
    // Fetch image from the internet
    final response = await http.get(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/my-3d-models-8417c.appspot.com/o/captain.png?alt=media&token=e172faae-78fb-4b4a-aad5-3519f5b4c85d"));
    if (response.statusCode == 200) {
      final bytesImage = response.bodyBytes;

      // Create ArCoreImage
      final arCoreImage = ArCoreImage(
        bytes: bytesImage,
        width: 100,
        height: 100,
      );

      // Create ArCoreNode with ArCoreImage
      final node = ArCoreNode(
        image: arCoreImage,
        position: vector64.Vector3(0.5, 0, 0),
        name: 'augmentedImageNode',
      );

      arCoreController!.addArCoreNode(node);
      nodes1.add(node);
    } else {
      print('Failed to load image from the internet');
    }
  }

  double calculateDistance(vector64.Vector3 position) {
    return position.length;
  }

  void onUpdate() {
    if (arCoreController == null) return;

    // Update the size of the nodes based on their distance to the camera
    for (var node in nodes1) {
      final distance = calculateDistance(node.position!.value);
      final scale = 1.0 / (distance + 1.0); // Adjust scaling factor as needed

      // Determine if the node is within the threshold distance
      final isClose = distance < distanceThreshold;

      // Remove and recreate the node with the updated scale
      arCoreController?.removeNode(nodeName: node.name);
      final updatedNode = ArCoreNode(
        shape: node.shape,
        position: node.position!.value,
        scale: vector64.Vector3.all(scale),
        name: node.name,
        children: isClose ? _createIndicatorNode(node.name) : [],
      );
      arCoreController?.addArCoreNode(updatedNode);
    }
  }

  List<ArCoreNode> _createIndicatorNode(String? parentName) {
    final indicatorMaterial = ArCoreMaterial(
      color: Colors.green,
    );
    final indicatorSphere =
        ArCoreSphere(radius: 0.05, materials: [indicatorMaterial]);
    final indicatorNode = ArCoreNode(
      shape: indicatorSphere,
      position: vector64.Vector3(0, 0.3, 0), // Position above the parent node
      name: 'indicator_$parentName',
    );
    return [indicatorNode];
  }

  void onItemTapped(String name) {
    // Find the node by name and remove it
    final node = findNodeByName(name);
    if (node != null) {
      arCoreController?.removeNode(nodeName: node.name);
      nodes1.remove(node);
    }
  }

  ArCoreNode? findNodeByName(String name) {
    try {
      return nodes1.firstWhere((node) => node.name == name);
    } catch (e) {
      return null;
    }
  }

  vector64.Vector3 getRandomPosition() {
    final random = Random();
    return vector64.Vector3(
      random.nextDouble() * 2 -
          1, // Random x between -1 and 1 (more controlled range)
      random.nextDouble() * 1.5 -
          0.5, // Random y between -0.5 and 1 (keeping objects within reach)
      -1 *
          (random.nextDouble() * 2 +
              1), // Random z between -1 and -3 (objects in front of the user)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
          enableTapRecognizer: true,
          enableUpdateListener: true,
          onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
