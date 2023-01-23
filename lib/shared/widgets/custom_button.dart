import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final double radius;
  final double padding;
  final double fontSize;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.text = 'write text',
    this.textColor = Colors.white,
    this.color = AppColors.primaryColor,
    this.borderColor = AppColors.primaryColor,
    this.radius = 5.0,
    this.padding = 5.0,
    this.fontSize = 14.0,
    this.width = double.infinity,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          padding:
              MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)),
          side: MaterialStateProperty.all(
            BorderSide(width: 1.w, color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          text: text,
          textStyle: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
