import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:justgrab_dine/presentation/Auth/sign_in/Sign_in.dart';

import '../../theme/colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<String> imgs = [
    'assets/imag1.png',
    'assets/image2.png',
    'assets/im2.png',
    "assets/im1.png"
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      body: ListView(
        children: [
          // SizedBox(
          //   height: size.height * 0.2,
          // ),
          Center(
            child: Container(
              height: size.height * 0.3,
              child: Image.asset("assets/log2.png"),
            ),
          ),
          Container(
            // decoration: BoxDecoration(co),
            child: CarouselSlider(
              options: CarouselOptions(
                initialPage: 2,
                height: size.height * 0.4,
                aspectRatio: 16 / 4,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: imgs.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(i));
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Container(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: gold1),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    )),
                child: Text(
                  "Get Started",
                  style: TextStyle(color: white1, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
