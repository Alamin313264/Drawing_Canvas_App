import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:canvas/view/drawing_canvas/page/bottom_color_page.dart';
import 'package:canvas/view/drawing_canvas/page/shape_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';



import '../models/drawing_mode.dart';
import '../models/sketch.dart';
import '../page/eraser_page.dart';

class CanvasBottomBar extends HookWidget {
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

  const CanvasBottomBar({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BottomItems(
          size: 25,
          iconData: FontAwesomeIcons.eraser,
          itemsSelected: drawingMode.value == DrawingMode.eraser,
          onTap: () {
            drawingMode.value = DrawingMode.eraser;
            eraserModalBottomSheet(context, eraserSize, drawingMode);
          },
          toolTip: 'Eraser',
        ),
        // Dynamically set the icon based on the selected DrawingMode
        ValueListenableBuilder<DrawingMode>(
          valueListenable: drawingMode,
          builder: (context, mode, child) {
            IconData icon = _getIconForDrawingMode(mode);

            return BottomItems(
              size: 25,
              iconData: icon,
              itemsSelected:  mode != DrawingMode.eraser,
              onTap: () {
                shapesModalBottomSheet(context, strokeSize, drawingMode,filled,polygonSides);
              },
              toolTip: 'Selected Tool',
            );
          },
        ),
        
        IconButton(
          onPressed: () async {
              if (backgroundImage.value != null) {
                backgroundImage.value = null;
              } else {
                backgroundImage.value = await _getImage;
              }
            },

            icon: const  Icon(FontAwesomeIcons.add) ),
        InkWell(
          onTap: (){
            colorModalBottomSheet(context, selectedColor, drawingMode);
          },
          child: ValueListenableBuilder<Color>(
            valueListenable: selectedColor,
            builder: (context, color, child) =>  CircleAvatar(
              backgroundColor: color,
              radius: 18,
            ),
          ),
        ),
        IconButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Download'),
                    content: const Text('What do you want?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Uint8List? pngBytes = await getBytes();
                            if (pngBytes != null) saveFile(pngBytes, 'png');
                          },
                          child: const Text("Export as PNG") ),
                      ElevatedButton(
                          onPressed: () async {
                            Uint8List? pngBytes = await getBytes();
                            if (pngBytes != null) saveFile(pngBytes, 'jpeg');
                          },
                          child: const Text("Export as JPEG") ),


                    ],
                  );
                },);
            },
            icon: const Icon(Icons.image,),iconSize: 30),


      ],
    );
  }

  IconData _getIconForDrawingMode(DrawingMode mode) {
    switch (mode) {
      case DrawingMode.pencil:
        return FontAwesomeIcons.pencil;
      case DrawingMode.line:
        return Icons.linear_scale; // or a similar line icon
      case DrawingMode.polygon:
        return Icons.hexagon_outlined;
      case DrawingMode.square:
        return FontAwesomeIcons.square;
      case DrawingMode.circle:
        return FontAwesomeIcons.circle;
      default:
        return FontAwesomeIcons.pencil;
    }
  }

  Future<Uint8List?> getBytes() async {
    RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }

  void saveFile(Uint8List bytes, String extension) async {
    if (kIsWeb) {
      html.AnchorElement()
        ..href = '${Uri.dataFromBytes(bytes, mimeType: 'image/$extension')}'
        ..download =
            'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension'
        ..style.display = 'none'
        ..click();
    } else {
      await FileSaver.instance.saveFile(
        name: 'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension',
        bytes: bytes,
        ext: extension,
        mimeType: extension == 'png' ? MimeType.png : MimeType.jpeg,
      );
    }
  }

  Future<ui.Image> get _getImage async {
    final completer = Completer<ui.Image>();
    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (file != null) {
        final filePath = file.files.single.path;
        final bytes = filePath == null
            ? file.files.first.bytes
            : File(filePath).readAsBytesSync();
        if (bytes != null) {
          completer.complete(decodeImageFromList(bytes));
        } else {
          completer.completeError('No image selected');
        }
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        completer.complete(
          decodeImageFromList(bytes),
        );
      } else {
        completer.completeError('No image selected');
      }
    }

    return completer.future;
  }




}


class BottomItems extends StatelessWidget{

  final IconData? iconData;
  final bool itemsSelected;
  final VoidCallback onTap;
  final Widget? child;
  final String? toolTip;

  final double size;

  const BottomItems({
    super.key,
     this.iconData,
    this.toolTip,
    this.child,
    required this.itemsSelected,
    required this.onTap,
    required this.size
  }) : assert(child != null || iconData != null);


  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: itemsSelected ? const Color(0xff98D2EB): Colors.grey.shade900,
              width: 1.5

            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),

          ),
          child:  Center(

            child: Tooltip(
                message: toolTip,
                preferBelow: false,
                child:
                    Icon(
                      iconData,
                      color: itemsSelected ? const Color(0xff98D2EB) : Colors.grey.shade900,
                      size: size,
                    ),
              ),
          ),
          ),
        ),

    );
  }

}

