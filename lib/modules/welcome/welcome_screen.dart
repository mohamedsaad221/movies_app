import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/signup_view/signup_screen.dart';
import 'package:movies_app/shared/styles/app_colors.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:movies_app/shared/widgets/custom_button.dart';

import '../../shared/helper/constance.dart';
import '../../shared/network/local/shared_pref.dart';
import '../../shared/responsive/responsive_widget.dart';
import '../../shared/widgets/background.dart';
import '../login_view/login_screen.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: CustomButton(onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: const MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatefulWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MobileWelcomeScreen> createState() => _MobileWelcomeScreenState();
}

class _MobileWelcomeScreenState extends State<MobileWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  CustomButton(
                    onPressed: () async {
                      await CacheHelper.saveData(key: 'isWelcome', value: true);
                      if(!mounted)return;
                      navigateAndFinish(context, const LoginScreen());
                    },
                    fontSize: defaultFontSize,
                    text: 'Login',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await CacheHelper.saveData(key: 'isWelcome', value: true);
                      if(!mounted)return;
                      navigateAndFinish(context, const SignUpScreen());
                    },
                    fontSize: defaultFontSize,
                    text: 'Signup',
                    textColor: AppColors.myBlack.withOpacity(.5),
                    color: AppColors.secondColor,
                    borderColor: AppColors.secondColor,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
