import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:helnay/api_provider/api_provider.dart';
import 'package:helnay/common/widgets/snack_bar_widget.dart';
import 'package:helnay/model/user/registration_user.dart';
import 'package:helnay/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:helnay/screen/map_screen/map_screen.dart';
import 'package:helnay/screen/notification_screen/notification_screen.dart';
import 'package:helnay/screen/search_screen/search_screen.dart';
import 'package:helnay/screen/user_detail_screen/user_detail_screen.dart';
import 'package:helnay/service/pref_service.dart';
import 'package:helnay/utils/app_res.dart';
import 'package:helnay/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/reverse_swipe_dialog.dart';

class ExploreScreenViewModel extends BaseViewModel {
  int imageIndex = 0;
  bool isLoading = false;
  SwiperController userController = SwiperController();
  List<RegistrationUserData>? userData;
  int currentUserIndex = 0;
  int? walletCoin = 0;
  RegistrationUserData? users;
  bool isSelected = false;

  void init() {
    exploreScreenApiCall();
    prefSetting();
  }

  void prefSetting() {
    PrefService.getSettingData().then((value) {
      ConstRes.settingData = value;
      notifyListeners();
    });
  }

  Future<void> exploreScreenApiCall() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    ApiProvider().getExplorePageProfileList().then((value) async {
      userData = value.data;
      isLoading = false;
      getProfileAPi();
      notifyListeners();
    });
  }

  Future<void> getProfileAPi() async {
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      users = value?.data;
      walletCoin = value?.data?.wallet;
      isSelected =
          await PrefService.getDialog(PrefConst.isDialogDialog) ?? false;
      await PrefService.saveUser(value?.data);
    });
  }

  bool isSocialBtnVisible(String? socialLink) {
    if (socialLink != null) {
      return socialLink.contains(AppRes.isHttp) ||
          socialLink.contains(AppRes.isHttps);
    } else {
      return false;
    }
  }

  Future<void> minusCoinApi() async {
    await ApiProvider().minusCoinFromWallet(ConstRes.reverseSwipePrice);
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
    )) throw '${AppRes.couldNotLaunch} ';
  }

  void onInstagramTap() {
    _launchUrl(userData?[currentUserIndex].instagram ?? '');
  }

  void onFBTap() {
    _launchUrl(userData?[currentUserIndex].facebook ?? '');
  }

  void onYoutubeTap() {
    _launchUrl(userData?[currentUserIndex].youtube ?? '');
  }

  void onPlayButton() async {
    userController.previous();
  }

  void onPlayButtonTap() async {
    if (users == null) {
      return;
    }
    if (users?.isBlock == 1) {
      return SnackBarWidget().snackBarWidget(AppRes.userBlock);
    } else {
      if (users?.isFake != 1) {
        if (ConstRes.reverseSwipePrice <= walletCoin! && walletCoin != 0) {
          !isSelected
              ? Get.dialog(
                  ReverseSwipeDialog(
                    isCheckBoxVisible: true,
                    walletCoin: walletCoin,
                    title1: AppRes.reverse,
                    title2: AppRes.swipe,
                    dialogDisc: AppRes.reverseSwipeDisc,
                    coinPrice: '${ConstRes.reverseSwipePrice}',
                    onCancelTap: () {
                      onBackBtnTap();
                    },
                    onContinueTap: (isSelected) {
                      PrefService.setDialog(
                          PrefConst.isDialogDialog, isSelected);
                      minusCoinApi().then(
                        (value) {
                          onBackBtnTap();
                          userController.previous();
                        },
                      );
                    },
                  ),
                ).then(
                  (value) {
                    getProfileAPi();
                  },
                )
              : onPreviousBtnTap();
        } else {
          Get.dialog(
            EmptyWalletDialog(
              onCancelTap: onBackBtnTap,
              onContinueTap: () {
                Get.back();
                Get.bottomSheet(const BottomDiamondShop());
              },
              walletCoin: walletCoin,
            ),
          );
        }
      } else {
        userController.previous();
      }
    }
  }

  void onPreviousBtnTap() {
    minusCoinApi().then((value) {
      getProfileAPi();
      userController.previous(animation: true);
    });
  }

  void onBackBtnTap() {
    Get.back();
  }

  int count = 0;

  void onNextButtonTap() {
    count++;

    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : userController.next(animation: true);
  }

  void onIndexChange(int index) {
    currentUserIndex = index;
    notifyListeners();
  }

  void onNotificationTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void onTitleTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const MapScreen());
  }

  void onSearchTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void onImageTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const UserDetailScreen(),
            arguments: userData?[currentUserIndex]);
  }

  void onLiveBtnTap() {
    // Get.to(() => const PremiumScreen());
  }

  void onEyeButtonTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const UserDetailScreen(showInfo: true),
            arguments: userData?[currentUserIndex]);
  }

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }
}
