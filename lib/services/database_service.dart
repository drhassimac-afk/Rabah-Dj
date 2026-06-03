import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
static Database? _db;

static Future<Database> get database async {
if (_db != null) return _db!;

```
final path = join(await getDatabasesPath(), 'rabahdj.db');

_db = await openDatabase(
  path,
  version: 1,
  onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user TEXT,
        text TEXT,
        image TEXT,
        likes INTEGER
      )
    ''');
  },
);

return _db!;
```

}
}
