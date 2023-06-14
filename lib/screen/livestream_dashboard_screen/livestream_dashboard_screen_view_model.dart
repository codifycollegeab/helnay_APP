import 'package:get/get.dart';
import 'package:helnay/api_provider/api_provider.dart';
import 'package:helnay/model/get_diamond_pack.dart';
import 'package:helnay/model/user/registration_user.dart';
import 'package:helnay/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:helnay/screen/live_stream_history_screen/live_stream_history_screen.dart';
import 'package:helnay/screen/live_stream_screen/live_stream_screen.dart';
import 'package:helnay/screen/redeem_screen/redeem_screen.dart';
import 'package:helnay/screen/submit_redeem_screen/submit_redeem_screen.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class LiveStreamDashBoardViewModel extends BaseViewModel {
  int eligible = 0;
  bool isLoading = false;
  RegistrationUserData? userData;
  String? coinValue;
  //BannerAd? bannerAd;

  void init() {
    getProfileApiCall();
    //getBannerAd();
  }

  void getProfileApiCall() {
    isLoading = true;
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      userData = value?.data;
      eligible = value?.data?.canGoLive == 0
          ? 0
          : value?.data?.canGoLive == 1
              ? 1
              : 2;
      coinValue = value?.data?.wallet.toString() ?? '0';
      isLoading = false;
      notifyListeners();
    });
  }

  void onRedeemTap() {
    Get.to(() => const SubmitRedeemScreen(), arguments: coinValue)
        ?.then((value) {
      getProfileApiCall();
    });
  }

  /* void onAddCoins() {
    Get.snackbar('HI !!', "This Feater will add to you in next version !",
        snackPosition: SnackPosition.BOTTOM);
  } */

  void onAddCoinsBtnTap() {
    Get.bottomSheet(
      const BottomDiamondShop(),
      backgroundColor: ColorRes.transparent,
    ).then((value) {
      getProfileApiCall();
    });
  }

  void onDiamondPurchase(GetDiamondPackData? data) {
/*     BubblyCamera.inAppPurchase(
        Platform.isAndroid ? data?.androidProductId : data?.iosProductId); */
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onHistoryBtnTap() {
    Get.to(() => const LiveStreamHistory());
  }

  void onRedeemBtnTap() {
    Get.to(() => const RedeemScreen());
  }

  /*  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  } */

  void onApplyBtnTap() {
    Get.to(() => const LiveStreamScreen())?.then((value) {
      getProfileApiCall();
    });
  }
}
