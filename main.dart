import 'package:aimushrooms/home.dart';
import 'package:aimushrooms/scanning.dart';
import 'package:aimushrooms/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //color: Colors.white,
        theme: ThemeData(
          colorScheme: ColorScheme.highContrastLight(),
          useMaterial3: true,),
      home:  Splash(),
    );
  }
}
