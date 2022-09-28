// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   Future initialize() async {
//     await Firebase.initializeApp();

//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     messaging.requestPermission();
//     await messaging.subscribeToTopic("all");
//     await messaging.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//     String? token = (await messaging.getToken());
//     print("token" + token.toString());
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);

//     FirebaseMessaging.onMessageOpenedApp.listen(backgroundHandler);
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings("@mipmap/launcher_icon"));

//     _notificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? route) async {
//       if (route != null) {
//         // Navigator.of(context).pushNamed(route);
//         print("notification route: $route");
//       }
//     });
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       FirebaseMessaging.onMessage.listen((message) {
//         if (message.notification != null) {
//           print("message for target blog");
//           print(message.notification!.body);
//           print(message.notification!.title);
//         }

//         LocalNotificationService.display(message);
//       });
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//       // final NotificationDetails notificationDetails = NotificationDetails(
//       //     android: AndroidNotificationDetails(
//       //   "easyapproach",
//       //   "easyapproach channel",

//       //   importance: Importance.max,
//       //   priority: Priority.high,
//       // ));

//       // await _notificationsPlugin.show(
//       //   id,
//       //   message.notification!.title,
//       //   message.notification!.body,

//       //   payload: message.data["target"],
//       // );
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print("hi");
//   print(message.data.toString());
//   print(message.notification!.title);
//   // this message data get from return firebase
//   if (message.data["target"] == "blogs") {
//     print("this is blog");
//     // Navigator.push(navigatorKey!.currentState!.context,
//     //     MaterialPageRoute(builder: (con) => PushBlogNotificatin()));
//     print("work");
//     // // then check blogs by id
//     // // compare id
//     // int targetId = int.tryParse(message.data["target_value"]) ?? 0;
//     // print("id $targetId");
//     // if (message.data["target_value"] == targetId) {
//     //   // print("correct");
//     //   // go to specific page
//     //   print("go ot specificate page");
//     // }
//     // Navigator.push(navigatorKey.currentState!.context, rote);
//   } else if (message.data["target"] == "categories") {
//     print("this is category");
//     // Navigator.push(navigatorKey!.currentState!.context,
//     //     MaterialPageRoute(builder: (con) => PushBlogNotificatin()));
//   } else {
//     print("course");
//   }
// }
