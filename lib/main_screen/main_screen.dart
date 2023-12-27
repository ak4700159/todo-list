import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/login/login_screen.dart';

import '../model/todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isReady = false;
  late List<Todo> todos;

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
  }

  @override
  void initState() {
    super.initState();
    todos = TodoDefault().getTodos();
    setState(() {
      isReady = true;
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('로그인창'),
                ),
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
                  const PopupMenuItem(child: ListTile(dense: false, leading: Icon(Icons.newspaper) ,title: Text('뉴스'))),
                  const PopupMenuItem(child: ListTile(leading: Icon(Icons.add) ,title: Text('추가'))),
                  const PopupMenuItem(child: ListTile(leading: Icon(Icons.logout) ,title: Text('로그아웃'))),
                ];
              },
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: !isReady
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: ListTile(
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
                                onTap: () {},
                                child: const Icon(Icons.edit),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {},
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
