
import 'package:canvas/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' hide Image;
import '../models/drawing_mode.dart';
import '../models/sketch.dart';



class CanvasTopBar extends HookWidget{

  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  final GlobalKey canvasGlobalKey;
  final ValueNotifier<bool> filled;
  final ValueNotifier<int> polygonSides;
  final ValueNotifier<ui.Image?> backgroundImage;

  const CanvasTopBar({super.key,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.currentSketch,
    required this.allSketches,
    required this.canvasGlobalKey,
    required this.filled,
    required this.polygonSides,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final undoRedoStack = useState(
      _UndoRedoStack(
        sketchesNotifier: allSketches,
        currentSketchNotifier: currentSketch,
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Undo Button
        IconButton(
          onPressed: allSketches.value.isNotEmpty
              ? () => undoRedoStack.value.undo()
              : null,
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states)=> Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
            ),
            ),
          ),
            icon: const Icon(Icons.undo,color: Colors.black87,),
        ),

        // Redo Button

        ValueListenableBuilder<bool>(
          valueListenable: undoRedoStack.value._canRedo,
          builder: (_, canRedo, __) {
            return IconButton(
              onPressed:
              canRedo ? () => undoRedoStack.value.redo() : null,
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states)=> Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
                ),
                ),
              ),
              icon:  const Icon(Icons.redo,color: Colors.black87),
            );
          },
        ),
        // Clear Button
        IconButton(
            onPressed: () => undoRedoStack.value.clear(),
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states)=> Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
            ),
            ),
          ),
            icon: const Icon(Icons.delete,color: Colors.black87,),
        ),
        IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings(),));
            },
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states)=> Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
            ),
            ),
          ),
            icon: const Icon(Icons.settings,color: Colors.black87,),
        ),
      ],
    );
  }

}



///A data structure for undoing and redoing sketches.
class _UndoRedoStack {
  _UndoRedoStack({
    required this.sketchesNotifier,
    required this.currentSketchNotifier,
  }) {
    _sketchCount = sketchesNotifier.value.length;
    sketchesNotifier.addListener(_sketchesCountListener);
  }

  final ValueNotifier<List<Sketch>> sketchesNotifier;
  final ValueNotifier<Sketch?> currentSketchNotifier;

  ///Collection of sketches that can be redone.
  late final List<Sketch> _redoStack = [];

  ///Whether redo operation is possible.
  ValueNotifier<bool> get canRedo => _canRedo;
  late final ValueNotifier<bool> _canRedo = ValueNotifier(false);

  late int _sketchCount;

  void _sketchesCountListener() {
    if (sketchesNotifier.value.length > _sketchCount) {
      //if a new sketch is drawn,
      //history is invalidated so clear redo stack
      _redoStack.clear();
      _canRedo.value = false;
      _sketchCount = sketchesNotifier.value.length;
    }
  }

  void clear() {
    _sketchCount = 0;
    sketchesNotifier.value = [];
    _canRedo.value = false;
    currentSketchNotifier.value = null;
  }

  void undo() {
    final sketches = List<Sketch>.from(sketchesNotifier.value);
    if (sketches.isNotEmpty) {
      _sketchCount--;
      _redoStack.add(sketches.removeLast());
      sketchesNotifier.value = sketches;
      _canRedo.value = true;
      currentSketchNotifier.value = null;
    }
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    final sketch = _redoStack.removeLast();
    _canRedo.value = _redoStack.isNotEmpty;
    _sketchCount++;
    sketchesNotifier.value = [...sketchesNotifier.value, sketch];
  }

  void dispose() {
    sketchesNotifier.removeListener(_sketchesCountListener);
  }
}
