import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class SqfliteProvider{
  static final tableName = 'user';
  late sql.Database db;

  SqfliteProvider() {
    init();
  }

  Future<void> init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'enft.db'),
      onCreate: (db, version) {
        final stmt = '''CREATE TABLE IF NOT EXISTS $tableName (
            id TEXT PRIMARY KEY,
            address TEXT,
            privateKey TEXT
        )'''.trim().replaceAll(RegExp(r'[\s]{2,}'), ' ');
        return db.execute(stmt);
      },
      version: 1,
    );
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db.query(table);
  }
}
