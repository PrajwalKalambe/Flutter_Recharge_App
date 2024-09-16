import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_recharge/provider/recharge_provider.dart';
import 'package:mobile_recharge/screens/history_screen.dart';
import 'package:mobile_recharge/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDjotfVWLnMXBFXtUmkKEZOdLJEXCHdqT8",
  authDomain: "mobile-recharge-app-8ef1f.firebaseapp.com",
  projectId: "mobile-recharge-app-8ef1f",
  storageBucket: "mobile-recharge-app-8ef1f.appspot.com",
  messagingSenderId: "41864241336",
  appId: "1:41864241336:web:ecc97f6b66fd3516cb544d"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RechargeProvider()),
        // Add other providers if needed
      ],
      child: MobileRechargeApp(),
    ),
  );
  }
  else{
    await Firebase.initializeApp();
    // Add this inside main function after Firebase.initializeApp()
FirebaseMessaging messaging = FirebaseMessaging.instance;

// Request permission
NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  badge: true,
  sound: true,
);

if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  print('User granted permission');
} else {
  print('User declined or has not accepted permission');
}

// Listen to messages
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Received a message in foreground: ${message.messageId}');
  // Show a notification or update UI accordingly
});
  }
}

class MobileRechargeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Recharge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/history': (context) => HistoryScreen(),
        // Add other routes as needed
      },
    );
  }
}