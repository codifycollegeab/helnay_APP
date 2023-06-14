// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/api_provider/notification_api.dart';
import 'package:helnay/model/note_model.dart';
import 'package:helnay/screen/notes_screen/controllers/note_controller.dart';
import 'package:helnay/screen/notes_screen/database/database.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';
import 'package:intl/intl.dart';

class ShowNote extends GetView<NoteHomeScreenControllerIMP> {
  final NoteModel noteData;
  final int index;
  ShowNote({super.key, required this.noteData, required this.index});
  final NoteHomeScreenControllerIMP authController =
      Get.find<NoteHomeScreenControllerIMP>();
  final NotificationController notificationController =
      Get.put(NotificationController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  late int x;

  @override
  Widget build(BuildContext context) {
    titleController.text = noteData.title!;
    bodyController.text = noteData.body!;
    x = noteData.notificationid!;
    var formattedDate =
        DateFormat.yMMMd().format(noteData.creationDate!.toDate());
    var time = DateFormat.jm().format(noteData.creationDate!.toDate());
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      "Show Note",
                      style: const TextStyle(
                        fontSize: 17,
                        color: ColorRes.black,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.showDeleteDialog(context, noteData);
                        notificationController.removeNotification(x);
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
                            Icons.delete,
                            color: ColorRes.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("$formattedDate at $time"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: titleController,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: "Title",
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: bodyController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: "Type something...",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorRes.orange,
          onPressed: () {
            if (titleController.text != noteData.title ||
                bodyController.text != noteData.body) {
              Database().updateNote(authController.x.toString(),
                  titleController.text, bodyController.text, noteData.id!);
              Get.back();
              titleController.clear();
              bodyController.clear();
            } else {
              controller.showSameContentDialog(context);
            }
          },
          label: Text("Save"),
          icon: Icon(
            Icons.save,
            color: ColorRes.white,
          ),
        ));
  }
}
