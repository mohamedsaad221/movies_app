import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/modules/login_view/cubit/login_cubit.dart';
import 'package:movies_app/shared/styles/app_theme.dart';

import 'modules/controlView/control_view.dart';
import 'modules/controlView/cubit/control_cubit.dart';
import 'shared/my_bloc_observer.dart';
import 'shared/network/local/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await CacheHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? const Size(375, 812)
            : const Size(812, 375),
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) =>
                  ControlCubit()..startMonitoring(),
            ),
            BlocProvider(
              create: (BuildContext context) => LoginCubit(),
            ),
          ],
          child: BlocBuilder<ControlCubit, ControlState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                home: const ControlView(),
              );
            },
          ),
        ),
      ),
    );
  }
}
