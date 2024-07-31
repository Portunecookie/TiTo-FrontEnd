import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tito_app/core/constants/style.dart';

import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
  // RemoteNotification? notification = message.notification;

  // if (notification != null) {
  //   FlutterLocalNotificationsPlugin().show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'high_importance_channel',
  //         'high_importance_notification',
  //         importance: Importance.max,
  //       ),
  //     ),
  //   );
  // }
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      FlutterLocalNotificationsPlugin().show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'high_importance_notification',
            importance: Importance.max,
          ),
        ),
      );
    }
  });

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future main() async {
  await dotenv.load(fileName: ".env");

  KakaoSdk.init(
    nativeAppKey: dotenv.env['OAUTH_KAKAO_NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['OAUTH_KAKAO_JAVASCRIPT_APP_KEY'],
  );
  runApp(const SafeArea(
    child: MyApp(),
  ));
  await Firebase.initializeApp();
  initializeNotification();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint(fcmToken);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // 피그마에 디자인 된 앱 프레임 사이즈로 맞춰서 적용한 것
      minTextAdapt: true, // 텍스트 크기를 자동으로 조정하여 화면에 맞추는 기능을 활성화
      splitScreenMode: true, // 분할 화면 모드를 활성화
      builder: (context, child) => ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Tito',
          theme: ThemeData(
            primaryColor: ColorSystem.purple,
          ),
        ),
      ),
    );
  }
}
