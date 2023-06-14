// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:helnay/screen/dashboard/dashboard_screen_view_model.dart';
import 'package:helnay/screen/dashboard/widgets/bottom_bar.dart';
import 'package:helnay/screen/explore_screen/explore_screen.dart';
import 'package:helnay/screen/live_stream_history_screen/live_stream_history_screen.dart';
import 'package:helnay/screen/message_screen/message_screen.dart';
import 'package:helnay/screen/profile_screen/profile_screen.dart';
import 'package:helnay/screen/randoms_screen/randoms_screen.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => DashboardScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: model.onBack,
          child: Scaffold(
            backgroundColor: ColorRes.white,
            bottomNavigationBar: BottomBar(
              pageIndex: model.pageIndex,
              onBottomBarTap: model.onBottomBarTap,
            ),
            body: SafeArea(
              bottom: false,
              child: model.pageIndex == 0
                  ? const ExploreScreen()
                  : model.pageIndex == 1
                      ? const RandomsScreen()
                      : model.pageIndex == 2
                          ? const LiveStreamHistory()
                          : model.pageIndex == 3
                              ? const MessageScreen()
                              : const ProfileScreen(),
            ),
          ),
        );
      },
    );
  }
}
