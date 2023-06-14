// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:helnay/screen/notes_screen/controllers/note_controller.dart';
import 'package:helnay/screen/notes_screen/widget/show_note.dart';
import 'package:intl/intl.dart';

class NoteList extends StatelessWidget {
  final NoteHomeScreenControllerIMP noteController =
      Get.find<NoteHomeScreenControllerIMP>();
  final lightColors = [
    Color(0xFFEF5350),
    Color(0xFFFF6F43),
    Color(0xFF6F6F6F),
    Color(0xFF1ED600),
    Color(0xFFFF0000),
    Color(0xFFF98C6C),
    Color(0xFFDB3D3D),
    Color(0xFFFF1414),
    Color(0xFF6F6F6F),
  ];

  NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 200,
      child: StaggeredGridView.countBuilder(
        itemCount: noteController.notes.length,
        staggeredTileBuilder: (index) =>
            StaggeredTile.fit(noteController.axisCount.value),
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          var formattedDate = DateFormat.yMMMd()
              .format(noteController.notes[index].creationDate!.toDate());
          Random random = Random();
          Color bg = lightColors[random.nextInt(8)];
          return GestureDetector(
            onTap: () {
              Get.to(() => ShowNote(
                  index: index, noteData: noteController.notes[index]));
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: bg,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      right: 8,
                      left: 8,
                      bottom: 0,
                    ),
                    title: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        noteController.notes[index].title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      noteController.notes[index].body!,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
