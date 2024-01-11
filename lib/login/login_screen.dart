import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/main_screen/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

  @override
  Widget build(BuildContext context) {
    Row LoginSubFields = Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '회원가입',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '아이디 찾기',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '비밀 번호 찾기',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
    Row LoginMainFields = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(
          flex: 4,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '아이디',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '패스워드',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              login();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll<ContinuousRectangleBorder?>(
                ContinuousRectangleBorder(
                  side: BorderSide(width: 2.0, color: Colors.black),
                ),
              ),
              fixedSize: MaterialStatePropertyAll<Size?>(Size(120, 120)),
              backgroundColor: MaterialStatePropertyAll<Color?>(Colors.blue),
            ),
            child: const Text(
              '로그인',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
    Container LoginTools = Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.black),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '로그인창',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          LoginMainFields,
          LoginSubFields,
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
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
            });
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('TO-DO LIST APP'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginTools,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      'assets/tree.jpg',
                      scale: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
