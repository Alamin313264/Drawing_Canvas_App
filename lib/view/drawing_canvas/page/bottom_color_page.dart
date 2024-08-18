





import 'package:canvas/view/drawing_canvas/widgets/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/drawing_mode.dart';
import '../widgets/bottom_bar.dart';





Future<void> colorModalBottomSheet(BuildContext context,ValueNotifier<Color> selectedColor,ValueNotifier<DrawingMode> drawingMode) {
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
                      "Color",
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

            const SizedBox(height: 20,),
            Expanded(
              child: ColorPalette(selectedColor: selectedColor),
            ),
          ],
        ),
      );
    },
  );
}