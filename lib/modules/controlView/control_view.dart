import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        var controlCubit = ControlCubit.get(context);
        return const WelcomeScreen();
      },
    );
  }
}

// return uId == null
// ? const LoginScreen()
// : controlCubit.isOnline
// ? const HomeLayoutScreen()
// : const NoInternet();
