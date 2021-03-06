import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        body: ModelViewer(
          backgroundColor: Colors.black,
          //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
          src: 'assets/laptop.glb', // a bundled asset file
          alt: "A 3D model of an astronaut",
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
      ),
    );
  }
}
