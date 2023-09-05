// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
      onSkip: () {
        // print('skipped');
        // Navigation to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      showPrevNextButton: true,
      showIndicator: true,
      backgourndColor: Colors.white,
      activeDotColor: Colors.blue,
      deactiveDotColor: Colors.grey,
      iconColor: Colors.black,
      leftIcon: Icons.arrow_circle_left_rounded,
      rightIcon: Icons.arrow_circle_right_rounded,
      iconSize: 30,
      pages: [
        OnBoardingModel(
          image: Image.asset("assets/images/img1.png"),
          title: "Business Chat",
          body:
              "First impressions are everything in business, even in chat service. It’s important to show professionalism and courtesy from the start",
        ),
        OnBoardingModel(
          image: Image.asset("assets/images/img2.png"),
          title: "Coffee With Friends",
          body:
              "When your morning starts with a cup of coffee and you are used to survive the day with the same, then all your Instagram stories and snapchat streaks would stay filled up with coffee pictures",
        ),
        OnBoardingModel(
          image: Image.asset("assets/images/img3.png"),
          title: "Mobile Application",
          body:
              "Mobile content marketing has also been found to enhance quick online actions and make follow-ups easier.",
        ),
      ],
    );
  }
}