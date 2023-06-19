import 'package:blog_app/models/blog_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'blog.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        '''
        CREATE TABLE blog(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            description TEXT
          )
        ''',
      ),
      version: _version,
    );
  }

  static Future<int> add(Blog blog) async {
    final db = await _getDB();
    return await db.insert(
      'blog',
      blog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> remove(int id) async {
    final db = await _getDB();
    return await db.delete('blog', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(Blog blog) async {
    final db = await _getDB();
    return await db.update(
      'blog',
      blog.toJson(),
      where: 'id = ?',
      whereArgs: [blog.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Blog>> getAllBlogs() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.query('blog', orderBy: 'title');
    return List.generate(maps.length, (index) => Blog.fromJson(maps[index]));
  }
}
