import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/login/login_screen.dart';
import 'package:todo_list/main_screen/main.dart';
import 'package:todo_list/model/sqlite.dart';
import '../model/todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isReady = true;
  List<Todo> todos = [];
  TodoSqlite todoSqlite = TodoSqlite();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future initDb() async {
    await todoSqlite.initDb().then((value) async {
      todos = await todoSqlite.getTodos();
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    showToast('로그아웃');
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      initDb().then((_) {
        setState(() {
          isReady = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AlertDialog(
              content: const SizedBox(
                width: 100,
                height: 30,
                child: Center(
                  child: Text(
                    '나가시겠습니까?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text("종료"),
                ),
              ],
            );
          },
        );
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'TO-DO List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: ListTile(
                      dense: false,
                      leading: Icon(Icons.newspaper),
                      title: Text('뉴스'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('추가'),
                      onTap: () {
                        String title = '';
                        String description = '';
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  '할일 추가하기',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.8)),
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              labelText: '제목',
                                            ),
                                            onChanged: (value) {
                                              title = value;
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            maxLines: 8,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.8,
                                                ),
                                              ),
                                              labelText: '세부내용',
                                            ),
                                            onChanged: (value) {
                                              description = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await todoSqlite.addTodo(Todo(
                                          title: title,
                                          description: description));
                                      List<Todo> newTodos =
                                          await todoSqlite.getTodos();
                                      setState(() {
                                        todos = newTodos;
                                      });
                                      showToast('추가완료 !');
                                      Navigator.pop(context);
                                    },
                                    child: const Text('추가'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('취소'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    onTap: logout,
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('로그아웃'),
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: isReady
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(todos[index].title),
                                content: Text(todos[index].description),
                              );
                            });
                      },
                      title: Text(todos[index].title),
                      subtitle: Text(todos[index].description),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.19,
                        //height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  String title = todos[index].title;
                                  String description = todos[index].description;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: AlertDialog(
                                          title: Text(
                                            '할 일 수정하기',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          content: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.8)),
                                                  child: TextField(
                                                    controller: titleController,
                                                    decoration: InputDecoration(
                                                      labelText: '제목',
                                                      hintText:
                                                          todos[index].title,
                                                    ),
                                                    onTap: (){
                                                      titleController.text = todos[index].title;
                                                    },
                                                    onChanged: (value) {
                                                      value = titleController.text;
                                                      title = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: TextField(
                                                    controller: contentController,
                                                    maxLines: 8,
                                                    decoration: InputDecoration(
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                      ),
                                                      labelText: '세부내용',
                                                      hintText: todos[index]
                                                          .description,
                                                    ),
                                                    onTap: (){
                                                      contentController.text = todos[index].description;
                                                    },
                                                    onChanged: (value) {
                                                      value = contentController.text;
                                                      description = value;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await todoSqlite
                                                    .updateTodo(Todo(
                                                  id: todos[index].id,
                                                  title: title,
                                                  description: description,
                                                ));
                                                List<Todo> newTodos =
                                                    await todoSqlite.getTodos();
                                                setState(() {
                                                  todos = newTodos;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text('수정'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('취소'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            '삭제하시겠습니까?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await todoSqlite.deleteTodo(
                                                    todos[index].id ?? 0);
                                                List<Todo> newTodos =
                                                    await todoSqlite.getTodos();
                                                setState(() {
                                                  todos = newTodos;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('삭제'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('취소'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: todos.length,
              ),
      ),
    );
  }
}
