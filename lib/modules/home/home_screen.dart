import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/login_screen.dart';
import 'package:movies_app/shared/styles/app_colors.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:movies_app/shared/widgets/custom_text.dart';

import '../../shared/helper/constance.dart';
import '../../shared/network/local/shared_pref.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'movies/movies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<HomeCubit>(context).getUserData();
  }

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
              body: FutureBuilder(
            future: cubit.getUserData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null && cubit.userModel == null) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Hi , ',
                            textStyle: TextStyle(
                              fontSize: defaultFontSize,
                            ),
                          ),
                          CustomText(
                            text: cubit.userModel!.name,
                            textStyle: TextStyle(
                                fontSize: defaultFontSize,
                                color: AppColors.primaryColor),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (_) => SizedBox(
                                  width: 271.w,
                                  height: 164.h,
                                  child: AlertDialog(
                                    content: CustomText(
                                      textAlign: TextAlign.center,
                                      text: 'Are you sure to log out ?',
                                      textStyle: TextStyle(
                                          fontSize: 16.sp,
                                          height: 1.2,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await CacheHelper.removeData(
                                                  key: 'isLogin');
                                              log(isLogin.toString());
                                              if (mounted) {
                                                return navigateAndFinish(
                                                    context,
                                                    const LoginScreen());
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  text: 'Yes',
                                                  textStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                const Icon(
                                                  Icons.check,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  text: 'No',
                                                  textStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                const Icon(
                                                  Icons.close,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.exit_to_app,
                              size: 25.w,
                              color: AppColors.errorColor,
                            ),
                          )
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
                                fontSize: 20.sp,
                                color: AppColors.myWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: defaultPadding,
                      ),
                    ],
                  ),
                );
              }
            },
          )),
        );
      },
    );
  }
}
