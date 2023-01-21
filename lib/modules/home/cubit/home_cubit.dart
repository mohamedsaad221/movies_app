import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/shared/helper/constance.dart';
import 'package:movies_app/shared/helper/end_points.dart';
import 'package:movies_app/shared/network/local/shared_pref.dart';

import '../../../models/movies_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/network/local/db.dart';
import '../../../shared/network/remote/api_request.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  // get movies

  MoviesModel? moviesModel;

  Future<void> getMovies() async {
    try {
      emit(GetMoviesLoading());

      Response response = await ApiRequest.getData(
        path: '$mostPopularMovies/$apiKey',
      );
      moviesModel = MoviesModel.fromJson(response.data);

      log(moviesModel!.items!.length.toString());

      LocalDB.instance.saveAllMoviesData(moviesList: moviesModel!.items!);

      emit(GetMoviesSuccess());
    } on DioError catch (error) {
      log('message: ${error.response!.statusMessage}');
      log('message: ${error.response!.statusCode}');

      emit(GetMoviesError());
    }
  }

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> getUserData() async {
    var email = await CacheHelper.getData(key: 'email');
    log('email: $email');
    _userModel = await LocalDB.instance.getUser(email: email ?? "");
    log('usermodel: ${userModel!.toJson()}');
  }
}
