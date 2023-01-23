import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../../shared/network/local/db.dart';
import '../../../shared/network/local/shared_pref.dart';
import '../../../shared/widgets/components.dart';
import '../../home/home_screen.dart';
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
    required bool mounted
  }) async {
    await LocalDB.instance.getLoginUser(
      email: emailController,
      passWord: passwordController,
      context: context,
      mounted: mounted
    );
    emit(UserLoginStateSuccess());
  }

  Future<void> signup({
    required String usernameController,
    required String emailController,
    required String passwordController,
    required BuildContext context,
    required bool mounted,
  }) async {
    await LocalDB.instance.saveUserData(
      userModel: UserModel(
        name: usernameController,
        email: emailController,
        password: passwordController,
      ),
    );
    await CacheHelper.saveData(key: 'isLogin', value: true);
    await CacheHelper.saveData(
        key: 'email', value: emailController);
    if (!mounted) return;
    navigateAndFinish(context, const HomeScreen());
    emit(SignUpStateSuccess());
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> items = await LocalDB.instance.getUserData();
    return items;
  }
}
