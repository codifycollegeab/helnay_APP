// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class CustomChoiceAlterDialogWidget extends StatelessWidget {
  void Function()? onPressedOlyDay;
  void Function()? onPressedeveryDay;
  CustomChoiceAlterDialogWidget(
      {super.key,
      required this.onPressedOlyDay,
      required this.onPressedeveryDay});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "Choice The Time",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
            "You have to choice the time you want have notificatioce notice you the time every day or only that day !!",
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onPressedeveryDay,
                  child: Text(
                    "EveryDay",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: onPressedOlyDay,
                  child: Text(
                    "Only Today",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
