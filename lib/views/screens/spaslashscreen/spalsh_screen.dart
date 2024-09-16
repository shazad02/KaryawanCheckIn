// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile2karyawan/theme.dart';
import 'package:mobile2karyawan/util/images.dart';
import 'package:mobile2karyawan/views/screens/firstscreen/first_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Timer? _timer;

  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const FirstScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      body: Center(
        child: Image.asset(
          Images.logo,
          width: MediaQuery.of(context).size.height * 30 / 100,
        ),
      ),
    );
  }
}
