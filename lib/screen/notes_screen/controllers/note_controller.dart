// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/model/note_model.dart';
import 'package:helnay/screen/notes_screen/database/database.dart';
import 'package:helnay/screen/notes_screen/widget/add_new_note.dart';

abstract class NoteHomeScreenController extends GetxController {
  void openBottomSheet();
  void showEmptyTitleDialog(BuildContext context);
  void showSameContentDialog(BuildContext context);
  void showDeleteDialog(BuildContext context, noteData);
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  });
}

class NoteHomeScreenControllerIMP extends NoteHomeScreenController {
  TextEditingController notTitleController = TextEditingController();
  RxList<NoteModel> noteList = RxList<NoteModel>();
  TextEditingController noteBodyController = TextEditingController();
  int? x;
  int notificationChoice = 0;
  Rx<int> axisCount = 2.obs;
  String? name;
  List<NoteModel> get notes => noteList.value;

  @override
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return time;
  }

  @override
  void onInit() {
    x = Get.arguments['id'];
    name = Get.arguments['fullname'];
    noteList.bindStream(Database().noteStream(x.toString()));
    notTitleController = TextEditingController();
    noteBodyController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    notTitleController.dispose();
    noteBodyController.dispose();
    super.dispose();
  }

  @override
  void openBottomSheet() {
    Get.to(() => AddNotePage());
  }

  @override
  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text(
            "Notes is empty!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            'The content of the note cannot be empty to be saved.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Okay",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void showSameContentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "No change in content!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text("There is no change in content.",
              style: Theme.of(context).textTheme.titleMedium),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Okay",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void showDeleteDialog(BuildContext context, noteData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Delete Note?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text("Are you sure you want to delete this note?",
              style: Theme.of(context).textTheme.titleMedium),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Get.back();
                Database().delete(x.toString(), noteData.id);
                Get.back(closeOverlays: true);
              },
            ),
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
