
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softtouch/modules/home/home_view.dart';
import 'package:softtouch/modules/splash_screen/splash_screen.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      home: SplashScreen(),
    );
  }
}
