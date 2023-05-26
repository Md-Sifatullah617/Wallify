import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'GetPhotos/wallpaper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Wallpaper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: Colors.white,
      child: Center(
        child: TextLiquidFill(
          loadDuration: const Duration(seconds: 3),
          waveDuration: const Duration(seconds: 2),
          text: 'Wallify',
          waveColor: Colors.black,
          boxBackgroundColor: Colors.white,
          textStyle: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              fontFamily: "Pacifico"),
          boxHeight: 300.0,
        ),
      ),
    );
  }
}
