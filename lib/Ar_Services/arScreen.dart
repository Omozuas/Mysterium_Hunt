import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.enablePlaneRenderer;
    arCoreController?.onPlaneTap = _handelOnPlanrTap;
// arCoreController?.addArCoreNodeWithAnchor(name)=
    displayCube(arCoreController!);
    displayCylinde(arCoreController!);
    displayEarth(arCoreController!);
  }

// to add image wen taped on screen
  addBoxNode(ArCoreHitTestResult plane) {
    final BoxNode = ArCoreReferenceNode(
        name: "Box",
        objectUrl:
            "https://firebasestorage.googleapis.com/v0/b/my-3d-models-8417c.appspot.com/o/puss_in_boots_pocket_shrek.glb?alt=media&token=12d65f53-155d-4bfa-8efe-3d09a48f8eaa",
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
        scale: plane.pose.translation.xyz);
    nodes1.add(BoxNode);
    arCoreController?.addArCoreNode(BoxNode);
  }

  _handelOnPlanrTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    addBoxNode(hit);
  }

  onTapHandler(String name) {
    print('Flutter: onNodeTap');
    showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Text("Renmove $name"),
                IconButton(
                    onPressed: () {
                      arCoreController?.removeNode(nodeName: name);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          );
        });
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
    final cylinder =
        ArCoreCylinder(height: 0.4, radius: 0.5, materials: [materials]);

    cylinderNode = ArCoreNode(
      shape: cylinder,
      position: vector64.Vector3(0.0, -0.5, -2.0),
      name: 'cylinderNode',
    );

    arCoreController!.addArCoreNode(cylinderNode!);
  }

  displayEarth(ArCoreController controller) async {
    final ByteData imageByte = await rootBundle.load('assets/images/eath.jpg');

    final materials = ArCoreMaterial(
        color: Colors.white, textureBytes: imageByte.buffer.asUint8List());
    final sphere = ArCoreSphere(materials: [materials]);

    final node =
        ArCoreNode(shape: sphere, position: vector64.Vector3(0, 0, -1.5));

    arCoreController!.addArCoreNode(node);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (cylinderNode != null) {
      // Access the current position
      final currentPosition = cylinderNode!.position!.value;

      // Calculate new position
      final newPosition = vector64.Vector3(
        currentPosition.x + details.delta.dx * 0.01,
        currentPosition.y + details.delta.dy * -0.01,
        currentPosition.z,
      );

      // Remove old node
      arCoreController?.removeNode(nodeName: cylinderNode!.name);
      final materials = ArCoreMaterial(
        color: Colors.blue,
        reflectance: 2,
      );
      final cylinder = ArCoreCylinder(
        height: 0.4,
        radius: 0.5,
        materials: [materials],
      );
      // Add new node with updated position
      cylinderNode = ArCoreNode(
        shape: cylinder,
        position: newPosition,
        name: 'cylinderNode',
      );

      arCoreController?.addArCoreNode(cylinderNode!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    arCoreController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onPanUpdate: _onPanUpdate,
          child: ArCoreView(
              enableUpdateListener: true,
              onArCoreViewCreated: onArCoreViewCreated)),
    );
  }
}
