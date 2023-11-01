import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.pageHeight,
    required this.pageWidth,
  });

  final double pageHeight;
  final double pageWidth;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: pageHeight * 0.011,
              bottom: pageHeight * 0.022,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset("assets/icons/email.svg"),
                ),
              ),
            ),
          ),
          const Text(
            "Password",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: pageHeight * 0.011,
              bottom: pageHeight * 0.022,
            ),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset("assets/icons/password.svg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: pageHeight * 0.011,
              bottom: pageHeight * 0.03,
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff77d8e),
                minimumSize: Size(double.infinity, pageHeight * 0.063),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_right_sharp),
              label: const Text("Sign In"),
            ),
          )
        ],
      ),
    );
  }
}
