import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/home_page.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/screens/login_register_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print(message.data.toString());

  //   // notificationNavigator(context,
  //   //     target: message.data["target"].toString(),
  //   //     targetValue: message.data["target_value"].toString());
  //   // // print("Handling a background message");
  // }

  // initNotification() async {
  //   Firebase.initializeApp().then((value) {
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;
  //     messaging.requestPermission();
  //     messaging.subscribeToTopic("all").then((value) {
  //       messaging
  //           .setForegroundNotificationPresentationOptions(
  //               alert: true, badge: true, sound: true)
  //           .then((value) {
  //         String? token;

  //         messaging.getToken().then((value) {
  //           token = value;
  //           print("token" + token.toString());
  //           FirebaseMessaging.instance.getInitialMessage().then((message) {
  //             print("FirebaseMessaging.getInitialMessage");
  //             if (message != null) {
  //               print(message);
  //               // Navigator.of(context).push(
  //               //     MaterialPageRoute(builder: (c) => NotificationPage()));
  //             }
  //           });
  //           FirebaseMessaging.onBackgroundMessage(
  //               firebaseMessagingBackgroundHandler);
  //           FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //             print("hi");
  //             // BlocProvider.of<AnnouncementBloc>(context)
  //             //     .add(SetReadingStatus(isRead: false));
  //           });

  //           FirebaseMessaging.onMessageOpenedApp
  //               .listen(firebaseMessagingBackgroundHandler);
  //         });
  //       });
  //     });
  //   });
  // }

  @override
  void initState() {
    // initNotification();
    super.initState();
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushAndRemoveUntil(context,
    //             MaterialPageRoute(builder: (context) {
    //           return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //               builder: (context, state) {
    //             if (state is Authenticated) {
    //               return Home();
    //             }
    //             if (state is NotAuthenticated) {
    //               return LoginRegisterPage();
    //             } else {
    //               return Scaffold(
    //                 body: Center(
    //                   child: CircularProgressIndicator(),
    //                 ),
    //               );
    //             }
    //             // return Home();
    //           });
    //         }), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Authenticated) {
        print("toke ${state.user.token} and name ${state.user.name}");
        return HomePage();
      }
      if (state is NotAuthenticated) {
        // return HomePage();
        return LoginRegisterPage(isLogin: true);
      }
      return Scaffold(
        body: Center(
          // child: CircularProgressIndicator(),
          child: Lottie.asset('assets/animation/loader.json',
              width: 200, height: 200),
        ),
      );
    });
  }
}
