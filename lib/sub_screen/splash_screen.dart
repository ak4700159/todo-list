import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/login/login_screen.dart';
import 'package:todo_list/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late bool _isLogin;

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool('isLogin') ?? false;
    return _isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((_isLogin) {
      if (_isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => (const MainScreen())),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => (const LoginScreen())),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    Timer(const Duration(seconds: 3), ( ){ });
    moveScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 3.0,
              color: Colors.black,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '로딩중',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  backgroundColor: Colors.red,
                  color: Colors.blue,
                  value: controller.value,
                  semanticsLabel: 'Circular progress indicator',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
