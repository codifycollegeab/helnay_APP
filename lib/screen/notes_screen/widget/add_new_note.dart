// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/api_provider/notification_api.dart';
import 'package:helnay/screen/notes_screen/controllers/note_controller.dart';
import 'package:helnay/screen/notes_screen/database/database.dart';
import 'package:helnay/screen/notes_screen/widget/show_choice_widget.dart';
import 'package:helnay/screen/options_screen/widgets/options_top_bar.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

class AddNotePage extends GetView<NoteHomeScreenControllerIMP> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationIddaily = UniqueKey().hashCode;
    final notificationIdeveryday = UniqueKey().hashCode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            OptionsTopBar(
                data: "ADD NEW NOTES",
                onBackBtnTap: () {
                  Get.back();
                }),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: null,
                        autofocus: true,
                        controller: controller.notTitleController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
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
                        controller: controller.noteBodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
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
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomChoiceAlterDialogWidget(
                        onPressedOlyDay: () async {
                          TimeOfDay? time = await controller.getTime(
                            context: context,
                            title: "Select Your Time",
                          );
                          if (controller.notTitleController.text.isEmpty &&
                              controller.noteBodyController.text.isEmpty) {
                            controller.showEmptyTitleDialog(context);
                          } else {
                            Database().addNote(
                              controller.x.toString(),
                              controller.notTitleController.text,
                              controller.noteBodyController.text,
                              notificationIddaily,
                            );
                            notificationController
                                .createNotificationDay(
                                  notificationIddaily,
                                  controller.notTitleController.text,
                                  controller.noteBodyController.text,
                                  time!.hour,
                                  time.minute,
                                )
                                .then((value) => {
                                      Get.back(),
                                    });
                            Get.back();
                          }
                        },
                        onPressedeveryDay: () async {
                          TimeOfDay? time = await controller.getTime(
                            context: context,
                            title: "Select Your Time",
                          );
                          if (controller.notTitleController.text.isEmpty &&
                              controller.noteBodyController.text.isEmpty) {
                            controller.showEmptyTitleDialog(context);
                          } else {
                            Database().addNote(
                              controller.x.toString(),
                              controller.notTitleController.text,
                              controller.noteBodyController.text,
                              notificationIdeveryday,
                            );
                            notificationController
                                .createNotificationrepeats(
                                  notificationIdeveryday,
                                  controller.notTitleController.text,
                                  controller.noteBodyController.text,
                                  time!.hour,
                                  time.minute,
                                )
                                .then((value) => {Get.back()});
                            Get.back();
                          }
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    color: ColorRes.orange.withOpacity(1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Add Notes",
                      style: TextStyle(
                        color: ColorRes.black,
                        fontFamily: FontRes.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
