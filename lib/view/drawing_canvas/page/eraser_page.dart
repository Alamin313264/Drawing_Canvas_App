

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/drawing_mode.dart';
import '../widgets/bottom_bar.dart';





Future<void> eraserModalBottomSheet(BuildContext context, ValueNotifier<double> eraserSize,ValueNotifier<DrawingMode> drawingMode) {
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
                      "Eraser",
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


            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  children: [
                    const Text(
                      'Eraser Size: ',
                      style: TextStyle(fontSize: 15, color: Color(0xff494F55),fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<double>(
                        valueListenable: eraserSize,
                        builder: (context, value, child) {
                          return Slider(
                            value: value,
                            min: 0,
                            max: 80,
                            onChanged: (val) {
                              eraserSize.value = val;
                            },
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder<double>(
                      valueListenable: eraserSize,
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
            ),
          ],
        ),
      );
    },
  );
}