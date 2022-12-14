import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(
    Map<String, dynamic> json,
  ) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  List<Todo> todos;

  AllTodos(this.todos);

  factory AllTodos.fromJson(List<dynamic> json) {
    var todos = json.map((index) => Todo.fromJson(index)).toList();
    return AllTodos(todos);
  }

  factory AllTodos.fromSnapshot(QuerySnapshot s) {
    List<Todo> todos = s.docs.map((DocumentSnapshot ds) {
      ds.id;
      return Todo.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllTodos(todos);
  }
}
