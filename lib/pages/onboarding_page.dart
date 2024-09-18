import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fotoin/widgets/animated_indicator.dart';
import 'package:fotoin/widgets/dot.dart';
import '../theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/login.dart';

const blue = Color(0xFF4781ff);
const kSubtitleStyle = TextStyle(fontSize: 22, color: Color(0xFF88869f));

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
            Slide(
                hero: Image.asset("assets/on1.png"),
                pageCon: true,
                pageCon1: false,
                pageCon2: false,
                title: "Enjoy Your Photoshoot",
                subtitle:
                    "Relax and enjoy your session while our professional photographers capture your special moments.",
                onNext: nextPage),
            Slide(
                hero: Image.asset(
                  "assets/on2.png",
                ),
                pageCon: false,
                pageCon1: true,
                pageCon2: false,
                title: "Explore Your Photographers",
                subtitle:
                    "Use our advanced search and filter options to find the perfect photographer for your needs.",
                onNext: nextPage),
            Slide(
                hero: Image.asset(
                  "assets/on3.png",
                ),
                title: "Enjoy Your Moments",
                pageCon: false,
                pageCon1: false,
                pageCon2: true,
                subtitle:
                    "Sit back and relax while our professional photographers do what they do best capturing your special moments beautifully.",
                onNext: nextPage),

            // Scaffold(
            //   body: SignIn(),
            // )
          ])),
    );
  }

  void nextPage() {
    if (pageController.page == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 10), curve: Curves.easeIn);
    }
  }
}

class Slide extends StatelessWidget {
  final Widget? hero;
  final String? title;
  final String? subtitle;
  final bool? pageCon;
  final bool? pageCon1;
  final bool? pageCon2;
  final VoidCallback? onNext;

  const Slide(
      {Key? key,
      this.hero,
      this.title,
      this.subtitle,
      this.pageCon,
      this.pageCon1,
      this.pageCon2,
      this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: hero,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "\n"+(title ?? "") +"\n\n",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: subtitle!, 
                                    style: GoogleFonts.inter(
                                        fontSize: 16, color: Colors.grey, fontWeight: regular),
                                  
                                  ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.26,
            left: MediaQuery.of(context).size.width * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Dot(active: pageCon!),
                SizedBox(width: 8), // Jarak antara dot
                Dot(active: pageCon1!),
                SizedBox(width: 8), // Jarak antara dot
                Dot(active: pageCon2!),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: 85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9381FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45))),
                onPressed: onNext,
                child: Text(
                  "NEXT",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback? onNext;
  const ProgressButton({Key? key, this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 17,
      height: 9,
      child: Stack(children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 20),
          size: 8 * 8,
          callback: onNext,
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 12,
              width: 12,
              child: Center(
                child: SvgPicture.asset(
                  "assets/arrow.svg",
                  width: 3,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 37, 170, 226)),
            ),
            onTap: onNext,
          ),
        )
      ]),
    );
  }
}
