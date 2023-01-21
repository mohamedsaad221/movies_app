import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../../shared/network/local/db.dart';
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

  Future<void> userLogin({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    await LocalDB.instance.getLoginUser(
      email: emailController,
      passWord: passwordController,
      context: context,
    );
    emit(UserLoginStateSuccess());
  }

  Future<void> signup({
    required String usernameController,
    required String emailController,
    required String passwordController,
  }) async {
    await LocalDB.instance.saveUserData(
      userModel: UserModel(
        name: usernameController,
        email: emailController,
        password: passwordController,
      ),
    );
    emit(SignUpStateSuccess());
  }
}
