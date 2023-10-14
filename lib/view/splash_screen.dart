import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stritva/constant.dart';
import '../view/home_page.dart';
import '../view/intro/second.dart';
import '../model/user_data.dart';
import 'package:provider/provider.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  Future<Widget> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    return Future.delayed(const Duration(seconds: 3), () {
      if (seen) {
        Provider.of<UserData>(context, listen: false).getUserFromPrefs();
        return HomePage();
      } else {
        // Set the flag to true at the end of the onboarding screen if everything is successful
        // and return FirstPage()
        return const SecondPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    final width = size.width;

    // Calculate the logo height and logo width based on screen size
    final logoHeight = height * 0.65;
    final logoWidth = width * 0.95;

    return EasySplashScreen(
      logo: Image.asset(
        'asset/images/logo.png',
        height: logoHeight,
        width: logoWidth,
        fit: BoxFit.contain,
      ),
      backgroundColor: backgroundColor,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: checkFirstSeen(),
    );
  }
}
