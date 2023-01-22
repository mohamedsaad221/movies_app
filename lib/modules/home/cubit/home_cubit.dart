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

  List<MoviesModelData> moviesLocalLength = [];

  MoviesModel? moviesModel;
  List<MoviesModelData> moviesList = [];

  Future<void> getAllMoviesLocal() async {
    moviesLocalLength = await LocalDB.instance.getAllMoviesLocal();
    if (moviesLocalLength.isNotEmpty) {
      moviesList = moviesLocalLength;
      log('moviesLocalLength:${moviesLocalLength.length}');
    }
    emit(GetMoviesLocalState());
  }

  Future<void> getMovies() async {
    try {
      moviesList = [];
      emit(GetMoviesLoading());

      Response response = await ApiRequest.getData(
        path: '$mostPopularMovies/$apiKey',
      );
      moviesModel = MoviesModel.fromJson(response.data);

      if (moviesModel != null) {
        await getAllMoviesLocal();
      }

      log('get all movie: ${moviesLocalLength.length}');

      moviesList = moviesModel!.items!;

      if (moviesModel!.items!.length > moviesLocalLength.length) {
        for (var movie in moviesModel!.items!) {
          LocalDB.instance.saveAllMoviesData(
              localMovieModel:
                  MoviesModelData(name: movie.name!, image: movie.image!));
        }
      }

      log('----- movies list: ${moviesModel!.items!.length.toString()} -----');

      emit(GetMoviesSuccess());
    } on DioError catch (error) {
      log('message: ${error.response?.statusMessage}');
      //log('message: ${error.response!.statusCode}');

      emit(GetMoviesError());
    }
  }

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool isLoading = false;

  Future<void> getUserData() async {
    isLoading = true;
    var email = await CacheHelper.getData(key: 'email');
    log('email: $email');
    isLoading = false;
    _userModel = await LocalDB.instance.getUser(email: email ?? "");
    log('usermodel: ${userModel!.toJson()}');
  }
}
