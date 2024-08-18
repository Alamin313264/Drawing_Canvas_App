import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../models/drawing_mode.dart";
import "../widgets/bottom_bar.dart";



Future<void> shapesModalBottomSheet(BuildContext context, ValueNotifier<double> strokeSize,
    ValueNotifier<DrawingMode> drawingMode,ValueNotifier<bool> filled,ValueNotifier<int> polygonSides) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,

        decoration: const BoxDecoration(
          color: Color(0xffFAF5EF),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff494F55),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Shapes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFAF5EF), // kCanvasColor replacement
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.close,
                      color: Color(0xffFAF5EF), // kCanvasColor replacement
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: [
                BottomItems(
                  size: 50,
                  iconData: FontAwesomeIcons.pencil,
                  itemsSelected: drawingMode.value == DrawingMode.pencil,
                  onTap: () {
                    drawingMode.value = DrawingMode.pencil;
                    Navigator.pop(context);
                  },
                  toolTip: 'Pencil',
                ),
                BottomItems(
                  size: 50,
                  itemsSelected: drawingMode.value == DrawingMode.line,
                  onTap: () {
                    drawingMode.value = DrawingMode.line;
                    Navigator.pop(context);
                  },
                  toolTip: 'Line',
                  iconData: Icons.linear_scale,
                ),
                BottomItems(
                  size: 50,
                  iconData: Icons.hexagon_outlined,
                  itemsSelected: drawingMode.value == DrawingMode.polygon,
                  onTap: () {
                    drawingMode.value = DrawingMode.polygon;
                    Navigator.pop(context);
                  },
                  toolTip: 'Polygon',
                ),
                BottomItems(
                  size: 50,
                  iconData: FontAwesomeIcons.square,
                  itemsSelected: drawingMode.value == DrawingMode.square,
                  onTap: () {
                    drawingMode.value = DrawingMode.square;
                    Navigator.pop(context);
                  },
                  toolTip: 'Square',
                ),
                BottomItems(
                  size: 50,
                  iconData: FontAwesomeIcons.circle,
                  itemsSelected: drawingMode.value == DrawingMode.circle,
                  onTap: () {
                    drawingMode.value = DrawingMode.circle;
                    Navigator.pop(context);
                  },
                  toolTip: 'Circle',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Fill Shape: ',
                    style: TextStyle(fontSize: 12),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: filled,
                    builder: (context, value, child) =>  Checkbox(
                      value: value,
                      onChanged: (val) {
                        filled.value = val ?? false;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: drawingMode.value == DrawingMode.polygon
                    ? Row(
                  children: [
                    const Text(
                      'Polygon Sides: ',
                      style: TextStyle(fontSize: 12),
                    ),
                    ValueListenableBuilder(
                        valueListenable: polygonSides,
                        builder: (context, value, child) => Slider(
                          value: value.toDouble(),
                          min: 3,
                          max: 8,
                          onChanged: (val) {
                            polygonSides.value = val.toInt();
                          },
                          label: '${polygonSides.value}',
                          divisions: 5,
                        ),
                    ),

                  ],
                )
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 10),
             Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const Text(
                      'Stroke Size: ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff494F55),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<double>(
                        valueListenable: strokeSize,
                        builder: (context, value, child) {
                          return Slider(
                            value: value,
                            min: 0,
                            max: 80,
                            onChanged: (val) {
                              strokeSize.value = val;
                            },
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: strokeSize,
                      builder: (context, value, child) {
                        return Text(
                          value.toStringAsFixed(1), // Display the eraser size value
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ],
                ),

            ),

          ],
        ),
      );
    },
  );
}
