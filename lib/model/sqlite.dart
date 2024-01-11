import 'package:sqflite/sqflite.dart';
import 'package:todo_list/model/todo.dart';

class TodoSqlite {
  late Database db;

  Future initDb() async {
    db = await openDatabase('my_db.db');
    await db.execute(
      'CREATE TABLE IF NOT EXISTS myTodo (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT)',
    );
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    List<Map<String, dynamic>> maps =
        await db.query('myTodo', columns: ['id', 'title', 'description']);
    for (var todo in maps) {
      todos.add(Todo.fromMap(todo));
    }
    return todos;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map<String, dynamic>> map = await db.query(
      'myTodo',
      columns: ['id', 'title', 'description'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return Todo.fromMap(map[0]);
    }
    return null;
  }

  Future addTodo(Todo todo) async {
    int id = await db.insert('myTodo', todo.toMap());
  }

  Future deleteTodo(int id) async {
    await db.delete(
      'myTodo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future updateTodo(Todo todo) async {
    await db.update(
      'myTodo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
