import 'package:HomeMonitor/models/DatabaseElement.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  String path;
  Database database;

  open() async {
    String computerPath = await getDatabasesPath();
    path = join(computerPath, 'home_monitor.db');
    // open the database
    database = await openDatabase(path, version: 1);
    return database;
  }

  // Delete the database
  delete() async {
    await deleteDatabase(path);
  }

  createDb(DatabaseElement lmnt) async {
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute('CREATE TABLE ' + lmnt.tableName + ' (' + lmnt.table + ')');
    });
    return database;
  }

  insertCredential(DatabaseElement databaseElement) async {
    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO Credentials(name, value) VALUES(?, ?)',
          ['hue_token', 'Il6y1HOhi4RZ3GICHulqq8wXuoUtwFV8Jx6AjUO3']);
      return id;
    });
  }

  update(DatabaseElement databaseElement) async {
    // Update some record
    int count = await database.rawUpdate(
        'UPDATE Credentials SET name = ?, value = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    return count;
  }

  Future<List<Map>> getAll() async {
    // Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Credentials');
    return list;
  }

  close() async {
    // Close the database
    await database.close();
  }
}
