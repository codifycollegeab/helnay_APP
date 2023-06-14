import 'package:get/get.dart';
import 'package:helnay/api_provider/api_provider.dart';
import 'package:helnay/model/fetch_redeem_request.dart';
import 'package:stacked/stacked.dart';

class RedeemScreenViewModel extends BaseViewModel {
  List<RedeemRequestData>? redeemData;
  bool isLoading = false;

  void init() {
    fetchRedeemRequest();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void fetchRedeemRequest() {
    isLoading = true;
    ApiProvider().fetchRedeemRequest().then((value) {
      redeemData = value.data;
      isLoading = false;
      notifyListeners();
    });
  }
}
