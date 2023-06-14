// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:helnay/utils/color_res.dart';

class CustomIconBtn extends StatelessWidget {
  final Color? color;
  void Function()? onPressed;
  final Widget? icon;
  CustomIconBtn({super.key, this.color, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        onPressed: onPressed,
        icon: icon!,
        color: ColorRes.white,
      ),
    );
  }
}
