import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/cubit/login_cubit.dart';
import 'package:movies_app/modules/login_view/cubit/login_state.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:movies_app/shared/widgets/custom_button.dart';

import '../../../models/user_model.dart';
import '../../../shared/helper/constance.dart';
import '../../../shared/network/local/shared_pref.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                hint: 'Email',
                prefixIcon: const Icon(Icons.email),
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Email Required';
                  }
                  return null;
                },
                colorBorder: AppColors.secondColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: CustomTextFormField(
                  controller: passwordController,
                  type: TextInputType.text,
                  hint: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  isPassword: cubit.isPassword,
                  maxLines: 1,
                  suffixIcon: cubit.suffix,
                  suffixPressed: cubit.changePasswordVisibility,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Password Required';
                    }
                    return null;
                  },
                  colorBorder: AppColors.secondColor,
                ),
              ),
              SizedBox(height: defaultPadding),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {

                    cubit.userLogin(
                      emailController: emailController.text,
                      passwordController: passwordController.text,
                      context: context,
                    );
                    await CacheHelper.saveData(key: 'isLogin', value: true);
                    await CacheHelper.saveData(
                        key: 'email', value: emailController.text);

                  }
                },
                fontSize: 18.sp,
                text: 'Login',
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        );
      },
    );
  }
}
