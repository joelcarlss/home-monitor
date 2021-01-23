import 'package:sqflite/sqflite.dart';
import 'DatabaseElement.dart';

class Credential extends DatabaseElement {
  Credential(this.name, {this.value});
  String tableName = 'Credentials';
  String table = 'id INTEGER PRIMARY KEY, name TEXT, value TEXT';
  int id;
  String name;
  String value;
  getValues() {
    return {name, value};
  }

  Credential.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    value = map['value'];
    name = map['name'];
  }

  Future<Credential> getFirst(Database database, val) async {
    List<Map> maps =
        await database.query(tableName, where: 'name = ?', whereArgs: [name]);
    print(maps.first);
    if (maps.length > 0) {
      return Credential.fromMap(maps.first);
    }
    return null;
  }
}
