import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_app/landing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      // Web configuration (ensure this matches your Firebase Web setup)
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyA4xGznr_WKr1M2WgPri_f6Y8wUnY_qmVc",
          authDomain: "loginauth-d8c65.firebaseapp.com",
          projectId: "loginauth-d8c65",
          storageBucket: "loginauth-d8c65.firebasestorage.app",
          messagingSenderId: "1021289058966",
          appId: "1:1021289058966:web:181f9cc1c4175adf59e8b7",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    runApp(const MyApp());
  } catch (e) {
    print("Firebase initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
