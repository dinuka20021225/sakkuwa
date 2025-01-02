import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color titleColor;
  const CustomButton({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: buttonColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "title",
              color: titleColor,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
