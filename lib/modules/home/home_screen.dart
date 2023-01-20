import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/login_screen.dart';
import 'package:movies_app/shared/styles/app_colors.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:movies_app/shared/widgets/custom_text.dart';

import '../../shared/helper/constance.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'movies/movies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: 'Hi , ',
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      CustomText(
                        text: 'Mohamed',
                        textStyle: TextStyle(
                            fontSize: 18.sp, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(context, const MoviesScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: AppColors.tealColor,
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'Go to movies',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              fontSize: 20.sp, color: AppColors.myWhite),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  InkWell(
                    onTap: () {
                      navigateAndFinish(context, const LoginScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'Sign Out',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              fontSize: 20.sp, color: AppColors.myWhite),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
