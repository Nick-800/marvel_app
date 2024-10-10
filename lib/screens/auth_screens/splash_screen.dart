import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';
import 'package:marvel_app/helpers/get_size.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/screens/auth_screens/login_screen.dart';
import 'package:marvel_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
// import 'package:marvel_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(animationDuration, () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ScreenRouter()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/comic.jpeg",
        height: getSize(context).height,
        width: getSize(context).width,
        fit: BoxFit.cover,
      ),
      Center(
          child: Image.asset(
        "assets/InvertedLogo.png",
        width: getSize(context).width * 0.8,
      )),
    ]);
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initializeAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, authenticationConsumer, child) {
      return AnimatedSwitcher(
        duration: animationDuration,
        child: authenticationConsumer.authenticated
            ? const HomeScreen()
            : const LoginScreen(),
      );
    });
  }
}
