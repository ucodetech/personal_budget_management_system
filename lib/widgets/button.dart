import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double iconSpacing;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;

  const Button({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = const Color.fromARGB(255, 63, 0, 49),
    this.textColor = Colors.white,
    this.borderRadius = 30.0,
    this.iconSpacing = 8.0,
    this.paddingVertical = 16.0,
    this.paddingHorizontal = 32.0,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: kToolbarHeight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            SizedBox(width: iconSpacing),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
