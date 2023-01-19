import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/shared/widgets/custom_button.dart';

import '../../../shared/helper/constance.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            type: null,
            hint: 'Username',
            prefixIcon: const Icon(Icons.person),
            validate: (value) {
              return;
            },
            colorBorder: AppColors.secondColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: CustomTextFormField(
              type: null,
              hint: 'Username',
              prefixIcon: const Icon(Icons.person),
              validate: (value) {
                return;
              },
              colorBorder: AppColors.secondColor,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          CustomButton(
            onPressed: () {},
            fontSize: 18.sp,
            text: 'Sign Up',
          ),
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
