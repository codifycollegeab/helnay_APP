// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:helnay/api_provider/api_provider.dart';
import 'package:helnay/model/get_diamond_pack.dart';
import 'package:stacked/stacked.dart';

class BottomDiamondShopViewModel extends BaseViewModel {
  List<GetDiamondPackData>? diamondPriceList = [];
  int? coinValue = 0;

  void init() {
    getDiamondPackApiCall();
  }

  void addCoinApiCall(int? coinValue) {
    ApiProvider().addCoinFromWallet(coinValue).then((value) {
      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }
      Get.back();
    });
  }

  void getDiamondPackApiCall() {
    ApiProvider().getDiamondPack().then((value) {
      diamondPriceList = value.data;
      notifyListeners();
    });
  }

  onDiamondPruncha() {
    Get.snackbar("The Error", 'This will add in a new version!',
        snackPosition: SnackPosition.BOTTOM);
  }

  onDiamondPrunchase(int data) async {
    await initPayment(amount: data, email: 'email@test.com');
  }

  Future<void> initPayment({
    required String email,
    required int amount,
  }) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-orangeflutter-c956e.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Helnay',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        testEnv: false,

        //customFlow: true,
        merchantCountryCode: 'us',
      ));
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar("Successs !", 'Payment is successful !',
          snackPosition: SnackPosition.BOTTOM);
      addCoinApiCall(amount);
    } catch (errorr) {
      if (errorr is StripeException) {
        Get.snackbar(
          "Error !",
          'An error occure ${errorr.error.localizedMessage}',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error !",
          "An error occured $errorr",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
