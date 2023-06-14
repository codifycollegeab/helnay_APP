// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helnay/screen/options_screen/widgets/options_top_bar.dart';
import 'package:helnay/utils/app_res.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptionsTopBar(
            data: AppRes.helpNSupport,
            onBackBtnTap: () {
              Get.back();
            },
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Text(
                "Have questions or need to report an issue with a Helnay product or service? We've got you covered . \nSo we can review any warring to you and we will notice you if we find any thing wrong with Helnay Application .\nYou can communicate with us through those applications responsible for the application",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                contactViaWhatsApp();
              },
              child: Container(
                height: 46,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.green3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/get_started/whatsapp.png',
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'WhatsApp',
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorRes.black2,
                        fontFamily: FontRes.semiBold,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

void contactViaWhatsApp() async {
  String whatsAppUrl = "";

  String phoneNumber = '447944321650';
  String description = "HI";

  if (Platform.isIOS) {
    whatsAppUrl =
        'whatsapp://wa.me/$phoneNumber/?text=${Uri.parse(description)}';
  } else {
    whatsAppUrl = 'https://wa.me/+$phoneNumber?text=${Uri.parse(description)}';
  }
  if (await canLaunch(whatsAppUrl)) {
    await launch(whatsAppUrl);
  } else {
    Get.snackbar("Error", "You have to install WhatsAppFirst",
        snackPosition: SnackPosition.BOTTOM);
  }
}
