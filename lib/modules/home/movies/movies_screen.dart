import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/modules/home/cubit/home_cubit.dart';
import 'package:movies_app/modules/home/cubit/home_state.dart';
import 'package:movies_app/shared/widgets/custom_text.dart';

import '../../../shared/helper/constance.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/default_cached_image.dart';
import '../../controlView/cubit/control_cubit.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isLoading = true;

  Future<void> init() async {
    if (BlocProvider.of<ControlCubit>(context).isOnline) {
      await BlocProvider.of<HomeCubit>(context).getMovies();
    } else {
      await BlocProvider.of<HomeCubit>(context).getAllMoviesLocal();
    }

    isLoading = false;
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CustomText(
              text: 'Movies',
              textStyle: TextStyle(fontSize: 18.sp, color: AppColors.myWhite),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  !isLoading
                      ? cubit.moviesModel != null
                          ? GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              clipBehavior: Clip.none,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 18,
                              childAspectRatio: 1.3.w / 2.2.h,
                              children: List.generate(
                                cubit.moviesList.length,
                                (index) => buildMovieItem(
                                    index: index,
                                    movie: cubit.moviesList[index]),
                              ),
                            )
                          : Center(
                              child: CustomText(
                                text:
                                    'something went wrong! , please try again',
                                textStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.errorColor,
                                ),
                              ),
                            )
                      : Center(
                          child: LoadingAnimationWidget.discreteCircle(
                              color: AppColors.primaryColor, size: 40.w),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMovieItem({required MoviesModelData movie, required int index}) {
    return Column(
      children: [
        DefaultCachedNetworkImage(
          imageUrl: movie.image!,
          width: double.infinity,
          height: 230.h,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          //height: 40.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(defaultRadius),
                  bottomRight: Radius.circular(defaultRadius)),
              color: AppColors.secondColor),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding / 2, horizontal: 4.w),
            child: CustomText(
              text: movie.name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 16.sp, color: AppColors.myBlack),
            ),
          ),
        ),
      ],
    );
  }
}
