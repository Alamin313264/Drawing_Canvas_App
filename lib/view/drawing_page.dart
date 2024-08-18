import 'dart:ui';

import 'package:canvas/view/drawing_canvas/widgets/top_bar.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.dart';
import 'drawing_canvas/drawing_canvas.dart';
import 'drawing_canvas/models/drawing_mode.dart';
import 'drawing_canvas/models/sketch.dart';
import 'drawing_canvas/widgets/bottom_bar.dart';
import 'drawing_canvas/widgets/canvas_side_bar.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kCanvasColor,
            width: double.maxFinite,
            height: double.maxFinite,
            child: DrawingCanvas(
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
              filled: filled,
              polygonSides: polygonSides,
              backgroundImage: backgroundImage,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom ,
            left:11,
            right: 11,
            child: Container(
              height: kBottomNavigationBarHeight +10,
              decoration: BoxDecoration(
                color: const Color(0xffB8B8B8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CanvasBottomBar(
                  selectedColor: selectedColor,
                  strokeSize: strokeSize,
                  eraserSize: eraserSize,
                  drawingMode: drawingMode,
                  currentSketch: currentSketch,
                  allSketches: allSketches,
                  canvasGlobalKey: canvasGlobalKey,
                  filled: filled,
                  polygonSides: polygonSides,
                  backgroundImage: backgroundImage),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top ,
            left:MediaQuery.of(context).padding.left,
            right: MediaQuery.of(context).padding.right,
            child: Container(
              height: kToolbarHeight,
              decoration: const BoxDecoration(
                color: Color(0xffB8B8B8),

              ),
              child: CanvasTopBar(
                  selectedColor: selectedColor,
                  strokeSize: strokeSize,
                  eraserSize: eraserSize,
                  drawingMode: drawingMode,
                  currentSketch: currentSketch,
                  allSketches: allSketches,
                  canvasGlobalKey: canvasGlobalKey,
                  filled: filled,
                  polygonSides: polygonSides,
                  backgroundImage: backgroundImage
              ),
            ),
          ),
        ],
      ),
    );
  }
}
