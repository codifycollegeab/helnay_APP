import 'package:get/get.dart';
import 'package:helnay/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class VideoCallingScreenViewModel extends BaseViewModel {
  void init() {}

  String image = AssetRes.profile17;
  Map<String, dynamic> userData = {
    'name': "Jhonson Smith",
    'age': 24,
    'address': "Las Vegas, USA",
    'tickMark': true,
  };

  void onBackBtnTap() {
    Get.back();
  }

  void onCameraSwitch() {}

  void onSpeakerTap() {}

  void onMoreBtnTap() {}

  void onCallCut() {
    Get.back();
  }

  void onSmallImageTap() {}
}
