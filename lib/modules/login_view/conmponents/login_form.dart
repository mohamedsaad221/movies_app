import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/cubit/login_cubit.dart';
import 'package:movies_app/modules/login_view/cubit/login_state.dart';
import 'package:movies_app/shared/widgets/custom_button.dart';

import '../../../shared/helper/constance.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
          child: Column(
            children: [
              CustomTextFormField(
                type: null,
                hint: 'Username',
                prefixIcon: const Icon(Icons.person),
                validate: (value) {},
                colorBorder: AppColors.secondColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: CustomTextFormField(
                  type: null,
                  hint: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  isPassword: cubit.isPassword,
                  maxLines: 1,
                  suffixIcon: cubit.suffix,
                  suffixPressed: cubit.changePasswordVisibility,
                  validate: (value) {
                    return;
                  },
                  colorBorder: AppColors.secondColor,
                ),
              ),
              SizedBox(height: defaultPadding),
              CustomButton(
                onPressed: () {},
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
