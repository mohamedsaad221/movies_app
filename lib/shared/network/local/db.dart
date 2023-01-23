import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/modules/home/home_screen.dart';
import 'package:movies_app/shared/helper/constance.dart';
import 'package:movies_app/shared/network/local/shared_pref.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();

  static Database? _database;

  LocalDB._init();

  static const _dbName = 'movieDb.db';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final dbPath = '$appDocPath/$dbName';

    debugPrint('----- database created successfully at: $dbPath -----');

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const textType = 'TEXT NOT NULL';
    const textType2 = 'TEXT UNIQUE';

    await db.execute('''
    CREATE TABLE $tableUser (
    ${UserModelFields.id} INTEGER PRIMARY KEY,
    ${UserModelFields.name} $textType ,
    ${UserModelFields.email} $textType2,
    ${UserModelFields.password} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableMovies (
    ${LocalMovieModelFields.id} INTEGER PRIMARY KEY,
    ${LocalMovieModelFields.name} $textType ,
    ${LocalMovieModelFields.image} $textType
 
    )
    ''');

    log('create tables');
  }

  /// working with [saveUserData] ////////////////////////////////////
  Future<int> saveUserData({
    required UserModel userModel,
  }) async {
    final db = await instance.database;
    int result = await db.insert(
      tableUser,
      userModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("saveUserData: $result");
    return result;
  }

  Future<void> saveAllMoviesData({
    required MoviesModelData localMovieModel,
  }) async {
    final db = await instance.database;
    int result = await db.insert(
      tableMovies,
      localMovieModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("saveAllMoviesData : $result");
  }

  Future<List<UserModel>> getUserData() async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(
      tableUser,
      columns: UserModelFields.values,
    );

    if (maps.isNotEmpty) {
      List<UserModel> items =
          maps.map((element) => UserModel.fromJson(element)).toList();

      debugPrint(
          '----- maps values ${maps.map((e) => e.values).toString()} -----');
      debugPrint('----- items length ${items.length.toString()} ------');

      return items;
    } else {
      return [];
    }
  }

  Future<List<MoviesModelData>> getAllMoviesLocal() async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(
      tableMovies,
      columns: LocalMovieModelFields.values,
    );

    if (maps.isNotEmpty) {
      List<MoviesModelData> items =
          maps.map((element) => MoviesModelData.fromJson(element)).toList();

      // debugPrint(
      //     '----- maps values movie ${maps.map((e) => e.values).toString()} -----');
      // debugPrint('----- items movie length ${items.length.toString()} ------');

      return items;
    } else {
      return [];
    }
  }

  Future<void> getLoginUser({
    required String email,
    required String passWord,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      final db = await instance.database;
      List<Map<String, Object?>> result =
          await db.rawQuery("SELECT * FROM $tableUser WHERE "
              "${UserModelFields.email} = '$email' And "
              "${UserModelFields.password} = '$passWord'");

      if (result.isEmpty) {
        showToast(
          text: 'We couldn\'t find an account that matched what you entered',
          stateColor: ShowToastColor.ERROR,
        );
      } else {
        log(result.toString());
        await CacheHelper.saveData(key: 'isLogin', value: true);
        await CacheHelper.saveData(key: 'email', value: email);
        if(!mounted) return;
        navigateAndFinish(context, const HomeScreen());
      }
    } on Exception catch (error) {
      log(error.toString());
    }
  }

  Future<UserModel?> getUser({required String email}) async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(
      tableUser,
      columns: UserModelFields.values,
      where: '${UserModelFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }

    return null;
  }
}
