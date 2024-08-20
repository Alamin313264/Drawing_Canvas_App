import 'package:canvas/view/drawing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color CanvasColor = Color(0xfff2f3f7);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing Canvas',
      theme: ThemeData(primarySwatch: Colors.blue,),
      debugShowCheckedModeBanner: false,
      home: const DrawingPage(),
    );
  }
}
