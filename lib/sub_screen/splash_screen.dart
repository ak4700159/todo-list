import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/sub_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    '이동하기',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
      ),
    );
  }
}
