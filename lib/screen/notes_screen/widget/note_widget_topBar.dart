// ignore_for_file: must_be_immutable, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/screen/notes_screen/controllers/note_controller.dart';
import 'package:helnay/screen/notes_screen/widget/custom_icon_btn.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

class NoteTopBar extends GetView<NoteHomeScreenControllerIMP> {
  final VoidCallback onBackBtnTap;
  String data;
  Widget? icon;
  void Function()? onPressed;

  NoteTopBar(
      {Key? key,
      required this.icon,
      required this.onBackBtnTap,
      required this.onPressed,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 45, 0, 18),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconBtn(
                color: Theme.of(context).colorScheme.background,
                onPressed: onPressed,
                icon: icon,
              ),
              Text(
                data,
                style: const TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontFamily: FontRes.bold,
                ),
              ),
              SizedBox(width: 23),
            ],
          ),
          InkWell(
            onTap: onBackBtnTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 37,
              width: 37,
              padding: const EdgeInsets.only(right: 3),
              decoration: const BoxDecoration(
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
        ],
      ),
    );
  }
}
