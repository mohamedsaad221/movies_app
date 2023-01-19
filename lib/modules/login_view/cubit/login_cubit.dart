import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isPassword = true;
  IconData suffix = Icons.visibility_off_rounded;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_off_rounded : Icons.visibility_outlined;

    emit(LoginPasswordVisibility());
  }
}
