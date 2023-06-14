// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

class EulaSheet extends StatelessWidget {
  final VoidCallback eulaAcceptClick;

  const EulaSheet({Key? key, required this.eulaAcceptClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppBar().preferredSize.height * 1.5),
      decoration: const BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              """
[Helnay] takes your privacy seriously. To better protect your privacy [["we" or "I"]] provide this privacy policy notice explaining the way your personal information is collected and used.
Collection of Routine Information
This [["website" or "app"]] track basic information about their [["visitors" or "users"]]. This information includes, but is not limited to, IP addresses, [["browser" or "app"]] details, timestamps and referring pages. None of this information can personally identify specific [# Privacy Policy
[Helnay] takes your privacy seriously. To better protect your privacy [["we" or "I"]] provide this privacy policy notice explaining the way your personal information is collected and used.
Collection of Routine Information
This [["website" or "app"]] track basic information about their [["visitors" or "users"]]. This information includes, but is not limited to, IP addresses, [["browser" or "app"]] details, timestamps and referring pages. None of this information can personally identify specific [["visitors" or "user"]] to this [["website" or "app"]]. The information is tracked for routine administration and maintenance purposes.
Cookies
Where necessary, this [["website" or "app"]] uses cookies to store information about a visitor’s preferences and history in order to better serve the [["visitor" or "user"]] and/or present the [["visitor" or "user"]] with customized content.
Advertisement and Other Third Parties
Advertising partners and other third parties may use cookies, scripts and/or web beacons to track [["visitors" or "user"]] activities on this [["website" or "app"]] in order to display advertisements and other useful information. Such tracking is done directly by the third parties through their own servers and is subject to their own privacy policies. This [["website" or "app"]] has no access or control over these cookies, scripts and/or web beacons that may be used by third parties. Learn how to opt out of Google’s cookie usage.
""",
            ),
          ),
          SafeArea(
            top: false,
            child: TextButton(
              onPressed: eulaAcceptClick,
              style: TextButton.styleFrom(
                backgroundColor: ColorRes.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'Accept',
                style: TextStyle(
                  color: ColorRes.white,
                  fontFamily: FontRes.semiBold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
