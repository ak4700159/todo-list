class Todo {
  late int? id;
  late String title;
  late String description;

  Todo({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // fromMap 이라는 이름의 생성자
  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
  }
}

class TodoDefault {
  List<Todo> dumy = [
    Todo(id: 1, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 2, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 3, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 4, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 5, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 6, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 7, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 8, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
    Todo(id: 9, title: '하윙', description: 'ㅁㄴㅇㅁㄴㅇㅁㄴㅇㄴㅁ'),
  ];

  Todo findTodo(int id) {
    return dumy[id];
  }

  List<Todo> getTodos() {
    return dumy;
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(title: todo.title, description: todo.description);
    dumy.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id) {
    for(int i = 0; i < dumy.length; i++){
      if(dumy[i].id == id){
        dumy.removeAt(i);
      }
    }
  }

  void updateTodo(Todo todo){
    for(int i = 0; i < dumy.length; i++){
      if(dumy[i].id == todo.id){
        dumy[i] = todo;
      }
    }
  }
}
