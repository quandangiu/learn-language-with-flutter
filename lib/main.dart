import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'login_screen.dart';
import 'main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Gemini
 

  // Load .env
  // Khởi tạo Firebase
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDmzVSZfi25oTjj2B_4zRsE2Xt1fsD9PSQ',
          authDomain: 'login-flutter-6f564.firebaseapp.com',
          projectId: 'login-flutter-6f564',
          storageBucket: 'login-flutter-6f564.firebasestorage.app',
          messagingSenderId: '170693680505',
          appId: '1:170693680505:web:e17c286657b51adc46a3a8',
          measurementId: 'G-4N4YT1PM9Q',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            debugPrint('StreamBuilder error: ${snapshot.error}');
            return LoginScreen();
          }
          if (!snapshot.hasData) {
            return LoginScreen();
          }
          return MainNavigation();
        },
      ),
    );
  }
}