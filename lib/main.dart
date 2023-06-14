import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:helnay/api_provider/notification_api.dart';
import 'package:helnay/screen/get_started_screen/get_started_screen.dart';
import 'package:helnay/utils/color_res.dart';
import 'package:helnay/utils/const_res.dart';

import './utils/.env';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorRes.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  NotificationController.initializeNotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishKey;
  await Stripe.instance.applySettings();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    saveTokenUpdate();

    super.initState();
  }

  void saveTokenUpdate() async {
    // await FirebaseMessaging.instance.subscribeToTopic("Orange");
    //await FirebaseMessaging.instance.getToken();

    /* await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    ); */

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'Helnay',
      'Helnay',
      playSound: true,
      description: 'Helnay',
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Helnay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: FontRes.regular,
        primaryColor: ColorRes.orange,
      ),
      home: const GetStartedScreen(),
    );
  }
}
