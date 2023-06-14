// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:helnay/common/widgets/loader.dart';
import 'package:helnay/screen/live_grid_screen/live_grid_screen_view_model.dart';
import 'package:helnay/screen/live_grid_screen/widgets/custom_grid_view.dart';
import 'package:helnay/screen/live_grid_screen/widgets/live_grid_top_area.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class LiveGridScreen extends StatelessWidget {
  const LiveGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveGridScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveGridScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              LiveGridTopArea(
                onBackBtnTap: model.onBackBtnTap,
                onGoLiveTap: model.goLiveBtnClick,
                userData: model.registrationUser,
              ),
              if (!model.isLoading)
                CustomGridView(
                  userData: model.userData,
                  onImageTap: model.onLiveStreamProfileTap,
                )
              else
                Expanded(
                  child: Loader().lottieWidget(),
                ),
              const SizedBox(
                height: 10,
              ),
              /*  if (model.bannerAd != null)
                Container(
                  alignment: Alignment.center,
                  width: model.bannerAd?.size.width.toDouble(),
                  height: model.bannerAd?.size.height.toDouble(),
                  child: AdWidget(ad: model.bannerAd!),
                ), */
            ],
          ),
        );
      },
    );
  }
}
