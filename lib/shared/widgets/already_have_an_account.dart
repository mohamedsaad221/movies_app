import 'package:flutter/material.dart';
import 'package:movies_app/shared/styles/app_colors.dart';
import 'package:movies_app/shared/widgets/custom_text.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(
          text: login ? "Don’t have an Account ? " : "Already have an Account ? ",
          textStyle: const TextStyle(color: AppColors.primaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: CustomText(
           text: login ? "Sign Up" : "Sign In",
            textStyle: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}