import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import '../../widgets/add_site_model.dart';
import '../../widgets/user_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._privateConstructor();

  DatabaseService._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Test.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute(
          'CREATE TABLE Site (id INTEGER PRIMARY KEY AUTOINCREMENT, userid INTEGER,url TEXT, siteName TEXT ,sector TEXT, socialMedia Text ,username TEXT ,password TEXT,notes TEXT,FOREIGN KEY(userid) REFERENCES User(id))');
      await db.execute(
          'CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, phone_number TEXT NOT NULL, password TEXT NOT NULL)');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Site>> getAllSite(int userid) async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT * FROM Site WHERE userid=${userid}');
    print("Site is ${result}");
    return result.length > 0
        ? result.map((json) => Site.fromJson(json)).toList()
        : [];
  }

  Future<List<Site>> getSiteFilter(int userid, String filter) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT * FROM Site WHERE userid=${userid} AND sector=\'${filter}\'');
    print("Site is ${result}");
    return result.length > 0
        ? result.map((json) => Site.fromJson(json)).toList()
        : [];
  }

  Future<Site> getSite(int id) async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM Site WHERE id=${id}');

    return result.map((json) => Site.fromJson(json)).toList()[0];
  }

  Future createSite(Map<String, dynamic> Site) async {
    final db = await instance.database;

    try {
      int result = await db.insert('Site', Site);

      return "Record inserted";
    } catch (e) {
      print(e);
      return Exception("Something went wrong");
    }
  }

  Future updateSite(Map<String, dynamic> Site) async {
    final db = await instance.database;

    try {
      int result = await db
          .update('Site', Site, where: 'id = ?', whereArgs: [Site["id"]]);

      return "Record updated";
    } catch (e) {
      print(e);
      return Exception("Something went wrong");
    }
  }

  Future deleteSite(int id) async {
    final db = await instance.database;

    try {
      int result = await db.delete('Site', where: 'id = ?', whereArgs: [id]);

      return "Record deleted";
    } catch (e) {
      print(e);
      return Exception("Something went wrong");
    }
  }

  Future<List<User>> getAllUser() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM User');
    print(result);
    return result.length > 0
        ? result.map((json) => User.fromJson(json)).toList()
        : [];
  }

  Future<User> getUser(int id) async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM User WHERE id=${id}');

    return result.map((json) => User.fromJson(json)).toList()[0];
  }

  Future<int> getUserByMobile(String mobile) async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT id FROM User WHERE phone_number=${mobile}');

    return result[0]['id'] as int;
  }

  Future<bool> checkExistanceUser(String mobile) async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT id FROM User WHERE phone_number=${mobile}');

    return result.length > 0 ? true : false;
  }

  Future getUserByData(String mobileNumber, String mPin) async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT * FROM User WHERE phone_number = ? ;', [mobileNumber]);
    if (result.isEmpty) {
      return '404';
    } else if (result[0]['password'] == mPin) {
      return '200';
    } else {
      return '401';
    }
  }

  Future createUser(Map<String, dynamic> user) async {
    final db = await instance.database;

    try {
      int result = await db.insert('User', user);

      return "Record inserted";
    } catch (e) {
      return Exception("Something went wrong");
    }
  }

  Future updateUser(Map<String, dynamic> user) async {
    final db = await instance.database;

    try {
      int result = await db
          .update('User', user, where: 'id = ?', whereArgs: [user["id"]]);

      return "Record updated";
    } catch (e) {
      return Exception("Something went wrong");
    }
  }

  Future deleteUser(int id) async {
    final db = await instance.database;

    try {
      int result = await db.delete('User', where: 'id = ?', whereArgs: [id]);

      return "Record deleted";
    } catch (e) {
      return Exception("Something went wrong");
    }
  }
}
