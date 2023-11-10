import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.result,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => VideoScreen()));
                },
                child: Text("Try Again"))
          ]),
    );
  }
}
