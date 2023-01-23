import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/home/home_screen.dart';
import 'package:movies_app/modules/login_view/login_screen.dart';

import '../../shared/helper/constance.dart';
import '../welcome/welcome_screen.dart';
import 'cubit/control_cubit.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlCubit, ControlState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return isWelcomeBool == true
            ? isLogin == true
                ? const HomeScreen()
                : const LoginScreen()
            : const WelcomeScreen();
      },
    );
  }
}
