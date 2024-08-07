import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class Arscreen extends StatefulWidget {
  const Arscreen({super.key});

  @override
  State<Arscreen> createState() => _ArscreenState();
}

class _ArscreenState extends State<Arscreen> {
  ArCoreController? arCoreController;
  onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    displayCube(arCoreController!);
    displayCylinde(arCoreController!);
  }

  displayCube(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.black,
      metallic: 2,
    );
    final cube = ArCoreCube(
        size: vector64.Vector3(0.5, 0.5, 0.5), materials: [materials]);

    final node =
        ArCoreNode(shape: cube, position: vector64.Vector3(-0.5, 0.5, -3.5));

    arCoreController!.addArCoreNode(node);
  }

  displayCylinde(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.blue,
      reflectance: 2,
    );
    final cube =
        ArCoreCylinder(height: 0.4, radius: 0.5, materials: [materials]);

    final node =
        ArCoreNode(shape: cube, position: vector64.Vector3(0.0, -0.5, -2.0));

    arCoreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
