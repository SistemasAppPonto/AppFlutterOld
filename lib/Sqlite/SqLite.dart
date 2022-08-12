import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'SQLUtil.dart';

class SqlHelper {
  static const String NOME_BASE_DADOS = "controle_combustivel.db";
  static final SqlHelper _instance = SqlHelper.internal();

  factory SqlHelper() => _instance;

  SqlHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDd();
      return _db;
    }
  }

  Future<Database> initDd() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, NOME_BASE_DADOS);

    return await openDatabase(path,
        version: 1, onCreate: create, onUpgrade: update);
  }

  void create(Database db, int newVersion) async {
    await db.execute(TabelaUsuario.createTable);
  }

  void update(Database db, int oldVersion, int newVersion) async {
//    await db.execute(TabelaUsuario.createTable);
  }
}
