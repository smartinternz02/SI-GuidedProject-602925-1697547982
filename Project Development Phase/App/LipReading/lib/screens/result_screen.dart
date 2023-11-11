import 'package:flutter/material.dart';
import 'package:rive_animation/screens/onboarding/onboarding_screen.dart';
import 'package:rive_animation/screens/video.dart';

class ResultScreen extends StatefulWidget {
  String result;
  ResultScreen({
    required this.result,
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Result",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: const Color(0xfff77d8e),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 10),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.fromLTRB(
              pageWidth * 0.15,
              pageHeight * 0.05,
              pageWidth * 0.15,
              pageHeight * 0.1,
            ),
            padding: EdgeInsets.symmetric(
              vertical: pageHeight * 0.02,
              horizontal: pageWidth * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Captions:",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xfff77d8e),
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.result,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const VideoScreen()));
                },
                icon: const Icon(Icons.replay),
                color: Colors.white,
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: const Color(0xfff77d8e),
                ),
              ),
              SizedBox(
                width: pageWidth * 0.05,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => const OnboardingScreen()));
                },
                icon: const Icon(Icons.home),
                color: Colors.white,
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: const Color(0xfff77d8e),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
