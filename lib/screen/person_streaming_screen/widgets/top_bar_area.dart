import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:helnay/model/chat_and_live_stream/live_stream.dart';
import 'package:helnay/utils/app_res.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onViewTap;
  final VoidCallback onExitTap;
  final VoidCallback onMoreBtnTap;
  final LiveStreamUser? liveStreamUser;
  final VoidCallback onUserTap;

  const TopBarArea(
      {Key? key,
      required this.onViewTap,
      required this.onExitTap,
      required this.onMoreBtnTap,
      this.liveStreamUser,
      required this.onUserTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 38),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              height: 60,
              width: Get.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.fromLTRB(13, 8, 23, 9),
              decoration: BoxDecoration(
                color: ColorRes.black4.withOpacity(0.33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: onUserTap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ConstRes.aImageBaseUrl}${liveStreamUser?.userImage}',
                        cacheKey:
                            '${ConstRes.aImageBaseUrl}${liveStreamUser?.userImage}',
                        errorWidget: (context, error, stackTrace) {
                          return Image.asset(
                            AssetRes.themeLabel,
                            width: 37,
                            height: 37,
                          );
                        },
                        height: 37,
                        width: 37,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11),
                  InkWell(
                    onTap: onUserTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              liveStreamUser?.fullName ?? '',
                              style: const TextStyle(
                                color: ColorRes.white,
                                fontSize: 16,
                                fontFamily: FontRes.bold,
                              ),
                            ),
                            Text(
                              " ${liveStreamUser?.age}",
                              style: const TextStyle(
                                color: ColorRes.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: ColorRes.white,
                                ),
                                Image.asset(
                                  AssetRes.tickMark,
                                  height: 18,
                                  width: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          liveStreamUser?.address ?? '',
                          style: const TextStyle(
                            color: ColorRes.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onMoreBtnTap,
                    child: Image.asset(
                      AssetRes.moreHorizontal,
                      height: 10,
                      width: 25,
                      fit: BoxFit.cover,
                      color: ColorRes.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: InkWell(
              onTap: onViewTap,
              child: Container(
                height: 39,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.fromLTRB(13, 4, 4, 4),
                decoration: BoxDecoration(
                  color: ColorRes.black4.withOpacity(0.33),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AssetRes.themeLabelWhite,
                          height: 20,
                          width: 69,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          AppRes.live,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onExitTap,
                          child: Row(
                            children: [
                              Image.asset(
                                AssetRes.exit,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                AppRes.exit,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 13),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "${NumberFormat.compact(locale: 'en').format(int.parse('${liveStreamUser?.watchingCount ?? '0'}'))} ${AppRes.viewers}",
                        style: const TextStyle(
                          color: ColorRes.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
