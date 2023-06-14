// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/screen/notes_screen/controllers/note_controller.dart';
import 'package:helnay/screen/notes_screen/widget/add_new_note.dart';
import 'package:helnay/screen/notes_screen/widget/note_list.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

class HomePageNoteApp extends GetWidget<NoteHomeScreenControllerIMP> {
  final NoteHomeScreenControllerIMP authController =
      Get.put(NoteHomeScreenControllerIMP());

  HomePageNoteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 37,
                          width: 37,
                          padding: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetRes.backButton),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              AssetRes.backArrow,
                              height: 14,
                              width: 7,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "NOTES",
                        style: const TextStyle(
                          fontSize: 17,
                          color: ColorRes.black,
                          fontFamily: FontRes.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authController.axisCount.value =
                              authController.axisCount.value == 2 ? 4 : 2;
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 37,
                          width: 37,
                          padding: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetRes.backButton),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                                authController.axisCount.value == 2
                                    ? Icons.list
                                    : Icons.grid_on,
                                color: ColorRes.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetX<NoteHomeScreenControllerIMP>(
                      init: Get.put<NoteHomeScreenControllerIMP>(
                          NoteHomeScreenControllerIMP()),
                      builder: (NoteHomeScreenControllerIMP noteController) {
                        if (noteController != null &&
                            noteController.notes != null) {
                          return NoteList();
                        } else {
                          return Text("No notes, create some ");
                        }
                      }),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorRes.orange,
          tooltip: "Add Note",
          onPressed: () {
            Get.to(() => AddNotePage());
          },
          child: Icon(
            Icons.note_add,
            size: 30,
          )),
    );
  }
}
