import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/video.dart';

import '../../widgets/animated_btn.dart';
import '../../widgets/signin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;
  int currentIndex = 0;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    List<Widget> items = [
      Container(
        margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.02),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/camera.svg",
              height: pageHeight * 0.2,
              width: pageHeight * 0.2,
            ),
            SizedBox(
              height: pageHeight * 0.025,
            ),
            const Text(
              "Effortlessly Convert Videos into Captions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
            ),
            SizedBox(
              height: pageHeight * 0.01,
            ),
            const Text(
              "Upload your videos, and let our app automatically generate accurate captions, making your content accessible to all.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.025),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/convo.svg",
              height: pageHeight * 0.2,
              width: pageHeight * 0.2,
            ),
            SizedBox(
              height: pageHeight * 0.025,
            ),
            const Text(
              "Real-time Captioning for Clearer Communication",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
            ),
            SizedBox(
              height: pageHeight * 0.01,
            ),
            const Text(
              "Upload your videos, and let our app automatically generate accurate captions, making your content accessible to all.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.025),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/conference.svg",
              height: pageHeight * 0.2,
              width: pageHeight * 0.2,
            ),
            SizedBox(
              height: pageHeight * 0.025,
            ),
            const Text(
              "Empower Daily Conversations with Captions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
            ),
            SizedBox(
              height: pageHeight * 0.01,
            ),
            const Text(
              "Upload your videos, and let our app automatically generate accurate captions, making your content accessible to all.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            width: pageWidth * 1.7,
            left: 120,
            bottom: 215,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 10,
              ),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 25,
                sigmaY: 25,
              ),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: pageHeight,
            width: pageWidth,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.075,
                  vertical: pageHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: pageWidth * 0.68,
                      child: Column(
                        children: [
                          const Text(
                            "Lip Reader",
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: pageHeight * 0.02,
                          ),
                          const Text(
                            "Welcome to the future of silent connection. Discover the power of lip reading and unlock a world of communication beyond words.",
                          )
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBtn(
                          btnAnimationController: _btnAnimationController,
                          press: () {
                            _btnAnimationController.isActive = true;
                            Future.delayed(
                              const Duration(milliseconds: 800),
                              () {
                                setState(() {
                                  isSignInDialogShown = true;
                                });
                                customSignInBox(
                                  context,
                                  pageWidth,
                                  pageHeight,
                                  items,
                                  currentIndex,
                                  onClosed: (_) {
                                    setState(() {
                                      isSignInDialogShown = false;
                                    });
                                  },
                                );
                              },
                            );
                          },
                          pageHeight: pageHeight,
                          pageWidth: pageWidth,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: pageHeight * 0.022),
                      child: const Center(
                        child: Text(
                          "Explore the Power of Lip Reading!",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Object?> customSignInBox(BuildContext context, double pageWidth,
      double pageHeight, List<Widget> items, int currentIndex,
      {required ValueChanged onClosed}) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Get Started",
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween;
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: pageWidth * 0.05,
          ),
          padding: EdgeInsets.symmetric(
            vertical: pageHeight * 0.032,
            horizontal: pageWidth * 0.055,
          ),
          height: pageHeight * 0.65,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: pageHeight * 0.04,
                    ),
                    CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                        aspectRatio: 2.0,
                        height: pageHeight * 0.42,
                        autoPlay: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        // enlargeFactor: 0.4,
                        // enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: pageHeight * 0.011,
                        bottom: pageHeight * 0.03,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const VideoScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff77d8e),
                          minimumSize:
                              Size(pageWidth * 0.55, pageHeight * 0.053),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(22),
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_right_sharp,color: Colors.white,),
                        label: const Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).then(onClosed);
  }
}
