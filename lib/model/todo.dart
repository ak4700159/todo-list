class Todo {
  late int? id;
  late String title;
  late String description;

  Todo({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titile': title,
      'description': description,
    };
  }

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

  void addTodo(Todo todo) {
    dumy.add(Todo(
      id: dumy.length + 1,
      title: todo.title,
      description: todo.description,
    ));
  }

  void deleteTodo(int id) {
    for(int i = 0; i < dumy.length; i++){
      if(dumy[i].id == id){
        dumy.remove(i);
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
