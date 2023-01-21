import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/modules/home/home_screen.dart';
import 'package:movies_app/shared/helper/constance.dart';
import 'package:movies_app/shared/widgets/components.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();

  static Database? _database;

  LocalDB._init();

  static const _dbName = 'movie.db';

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

    await db.execute('''
    CREATE TABLE $tableUser (
    ${UserModelFields.id} INTEGER PRIMARY KEY,
    ${UserModelFields.name} $textType,
    ${UserModelFields.email} $textType,
    ${UserModelFields.password} $textType
    )
    ''');

    // await db.execute('''
    // CREATE TABLE $tableAttachAssess (
    // ${LocalAttachmentModelFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    // ${LocalAttachmentModelFields.userId} $intType,
    // ${LocalAttachmentModelFields.schoolId} $intType,
    // ${LocalAttachmentModelFields.settingKpiId} $intType,
    // ${LocalAttachmentModelFields.attachmentName} $textType,
    // ${LocalAttachmentModelFields.attachmentExt} $textType,
    // ${LocalAttachmentModelFields.attachmentSize} $textType,
    // ${LocalAttachmentModelFields.attachmentType} $textType,
    // ${LocalAttachmentModelFields.attachmentPath} $textType,
    // ${LocalAttachmentModelFields.uploaded} $textType
    // )
    // ''');
    //
    // await db.execute('''
    // CREATE TABLE $tableVisitedSchools (
    // ${LocalVisitedSchoolsFields.schoolId} INTEGER PRIMARY KEY,
    // ${LocalVisitedSchoolsFields.schoolName} $textType,
    // ${LocalVisitedSchoolsFields.userFullName} $textType,
    // ${LocalVisitedSchoolsFields.locationLat} $textType,
    // ${LocalVisitedSchoolsFields.locationLng} $textType,
    // ${LocalVisitedSchoolsFields.visitStartDate} $textTypeNull,
    // ${LocalVisitedSchoolsFields.visitEndDate} $textTypeNull,
    // ${LocalVisitedSchoolsFields.creationDate} $textTypeNull,
    // ${LocalVisitedSchoolsFields.visited} $intType,
    // ${LocalVisitedSchoolsFields.isUploaded} $textType
    // )
    // ''');
  }

  /// working with [saveUserData] ////////////////////////////////////
  Future<void> saveUserData({
    required UserModel userModel,
  }) async {
    final db = await instance.database;
    await db.insert(
      tableUser,
      userModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<UserModel?> getLoginUser(
      {required String userName, required String passWord,required BuildContext context}) async {
    final db = await instance.database;
    await db
        .rawQuery("SELECT * FROM $tableUser WHERE "
            "${UserModelFields.name} = '$userName' And "
            "${UserModelFields.password} = '$passWord'")
        .then((value) {
      log(value.toString());
      if (value.isEmpty) {
        showToast(
            text: 'Confirm the mobile number or password you entered',
            stateColor: ShowToastColor.ERROR,
        );
      } else {
        navigateAndFinish(context, const HomeScreen());
      }
    }).catchError((error) {
      log(error.toString());
    });

    return null;
  }

  // Future<LocalVisitedSchoolsModel?> getSingleVisitedSchoolsData(
  //     int? schoolId) async {
  //   final db = await instance.database;
  //
  //   List<Map<String, dynamic>> maps = await db.query(
  //     tableVisitedSchools,
  //     columns: LocalVisitedSchoolsFields.values,
  //     where: '${LocalVisitedSchoolsFields.schoolId} = ?',
  //     whereArgs: [schoolId],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     return LocalVisitedSchoolsModel.fromJson(maps.first);
  //   }
  //
  //   return null;
  // }

  // Future<int> updateVisitedSchoolData(
  //     LocalVisitedSchoolsModel localVisitedSchoolsModel) async {
  //   final db = await instance.database;
  //
  //   return await db.update(
  //     tableVisitedSchools,
  //     localVisitedSchoolsModel.toJson(),
  //     where: '${LocalVisitedSchoolsFields.schoolId} = ?',
  //     whereArgs: [localVisitedSchoolsModel.schoolId],
  //   );
  // }

  // /// working with [saveVisitAssessData] ///////////////////////////////////////
  // Future<void> saveVisitAssessData({
  //   required LocalVisitAssessModel localVisitAssessModel,
  //   required String schoolId,
  // }) async {
  //   List<LocalVisitAssessModel> list = await getVisitAssessData();
  //
  //   if (list.isNotEmpty) {
  //     for (var item in list) {
  //       if (item.settingKpiId == localVisitAssessModel.settingKpiId) {
  //         int updateCode = await updateAssesData(localVisitAssessModel);
  //
  //         if (updateCode == 1) {
  //           debugPrint('----- updateCode: $updateCode -----');
  //           debugPrint('----- تم تعديل المعيار -----');
  //           showToast(
  //               text: 'تم تعديل المعيار', stateColor: ShowToastColor.success);
  //         } else {
  //           debugPrint('----- updateCode: $updateCode -----');
  //         }
  //       }
  //     }
  //
  //     final db = await instance.database;
  //     await db
  //         .insert(
  //       tableVisitAssess,
  //       localVisitAssessModel.toJson(),
  //     )
  //         .then((value) {
  //       debugPrint('----- تم حفظ المعيار -----');
  //       showToast(text: 'تم حفظ المعيار', stateColor: ShowToastColor.success);
  //     });
  //   } else {
  //     final db = await instance.database;
  //     await db
  //         .insert(
  //       tableVisitAssess,
  //       localVisitAssessModel.toJson(),
  //     )
  //         .then((value) {
  //       debugPrint('----- تم حفظ المعيار -----');
  //       showToast(text: 'تم حفظ المعيار', stateColor: ShowToastColor.success);
  //     });
  //   }
  // }
  //
  // Future<List<LocalVisitAssessModel>> getVisitAssessData() async {
  //   final db = await instance.database;
  //
  //   List<Map<String, dynamic>> maps = await db.query(
  //     tableVisitAssess,
  //     columns: LocalVisitAssessModelFields.values,
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     List<LocalVisitAssessModel> items = maps
  //         .map((element) => LocalVisitAssessModel.fromJson(element))
  //         .toList();
  //
  //     debugPrint(
  //         '----- maps values ${maps.map((e) => e.values).toString()} -----');
  //     debugPrint('----- items length ${items.length.toString()} ------');
  //
  //     return items;
  //   } else {
  //     return [];
  //   }
  // }
  //
  // Future<List<LocalAttachmentModel>> getVisitAttachData() async {
  //   final db = await instance.database;
  //
  //   List<Map<String, dynamic>> maps = await db.query(
  //     tableAttachAssess,
  //     columns: LocalAttachmentModelFields.values,
  //     // where: '${LocalAttachmentModelFields.schoolId} = ?',
  //     // whereArgs: [schoolId],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     List<LocalAttachmentModel> items = maps
  //         .map((element) => LocalAttachmentModel.fromJson(element))
  //         .toList();
  //
  //     debugPrint(
  //         '----- maps values ${maps.map((e) => e.values).toString()} -----');
  //     debugPrint('----- items length ${items.length.toString()} ------');
  //
  //     return items;
  //   } else {
  //     return [];
  //   }
  // }

  /// working with [closeDB] //////////////////////////////////////
  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
