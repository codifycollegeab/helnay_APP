// ignore_for_file: file_names, await_only_futures
import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  StreamSubscription<ReceivedAction>? actionStreamSubscription;
  void listen() async {
    // You can choose to cancel any exiting subscriptions
    await actionStreamSubscription?.cancel();

    // assign the stream subscription
    actionStreamSubscription =
        AwesomeNotifications().actionStream.listen((message) {
      AwesomeNotifications()
          .getGlobalBadgeCounter()
          .then((value) => AwesomeNotifications().setGlobalBadgeCounter(0))
          .ignore();
      // handle stuff here
    });
  }

  static void initializeNotificationService() {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: "basic_channel_key",
        channelName: "Basic Channel",
        channelDescription: "Used to send the main notifications to our users",
        channelShowBadge: true,
        defaultColor: Colors.deepPurple,
        enableLights: true,
        enableVibration: true,
        //setting this to high or max will cause the notification to drop down from the top
        importance: NotificationImportance.Max,
        playSound: true,
      )
    ]);
  }

  Future<void> createPictureNotification(
    String title,
    String body,
    String imagePath,
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        //The id should be unique
        id: 2,
        channelKey: 'basic_channel_key',
        title: '$title ${Emojis.art_framed_picture}',
        body: body,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: imagePath,
      ),
    );
  }

  Future<void> removeNotification(id) async {
    AwesomeNotifications().dismiss(id);
  }

  Future<void> createNotificationDay(
    int id,
    String title,
    String body,
    int? hour,
    int? minute,
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        //The id should be unique
        id: id,
        channelKey: 'basic_channel_key',
        title: '$title ${Emojis.video_camera_with_flash}',
        body: body,
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        repeats: false,
      ),
    );
  }

  Future<void> createNotificationrepeats(
    int id,
    String title,
    String body,
    int? hour,
    int? minute,
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        //The id should be unique
        id: id,
        channelKey: 'basic_channel_key',
        title: '$title ${Emojis.video_camera_with_flash}',
        body: body,
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        repeats: true,
      ),
    );
  }

  Future<void> cleareAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () async {
      await actionStreamSubscription?.cancel();
    });
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    if (actionStreamSubscription == null) {
      //listen();
    } else {
      listen();
    }
    //Request permission from user to show notifications
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }
}
