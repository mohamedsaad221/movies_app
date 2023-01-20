import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/cubit/login_state.dart';
import 'package:movies_app/shared/widgets/custom_button.dart';

import '../../../shared/helper/constance.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../login_view/cubit/login_cubit.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();

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
                controller: usernameController,
                type: TextInputType.text,
                hint: 'Username',
                prefixIcon: const Icon(Icons.person),
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Username Required';
                  }
                  return null;
                },
                colorBorder: AppColors.secondColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: CustomTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  hint: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Email Required';
                    } else if (!emailController.text.contains('@')) {
                      return 'Email is invalid';
                    }
                    return null;
                  },
                  colorBorder: AppColors.secondColor,
                ),
              ),
              CustomTextFormField(
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
              SizedBox(height: defaultPadding / 2),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                fontSize: 18.sp,
                text: 'Sign Up',
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        );
      },
    );
  }
}
