import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/screen/get_started_screen/widget/bottom_info_field.dart';
import 'package:helnay/utils/app_res.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:helnay/utils/color_res.dart';

class Screen4 extends StatelessWidget {
  final VoidCallback onNextTap;
  final VoidCallback onSkipTap;

  const Screen4({
    Key? key,
    required this.onNextTap,
    required this.onSkipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.white,
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height / 1.9,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Image.asset(
                AssetRes.getStarted4BG,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: Get.width,
            height: Get.height / 1.9,
            child: Center(
              child: Image.asset(
                AssetRes.getStarted4Camera,
                width: Get.width / 2.3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomInfoField(
            title: AppRes.streamYourself,
            subTitle: AppRes.getStarted4Subtitle,
            onNextTap: onNextTap,
            onSkipTap: onSkipTap,
            buttonText: AppRes.allow,
          )
        ],
      ),
    );
  }
}
