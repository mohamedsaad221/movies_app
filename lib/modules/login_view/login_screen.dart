import 'package:flutter/material.dart';
import 'package:movies_app/modules/signup_view/signup_screen.dart';
import 'package:movies_app/shared/widgets/already_have_an_account.dart';
import 'package:movies_app/shared/widgets/components.dart';

import '../../shared/responsive/responsive_widget.dart';
import '../../shared/widgets/background.dart';
import 'conmponents/login_form.dart';
import 'conmponents/login_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            const Spacer(),

          ],
        ),
        AlreadyHaveAnAccountCheck(press:(){
          navigateTo(context, const SignUpScreen());
        } ,login: true,),
      ],
    );
  }
}
