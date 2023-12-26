import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _LoginSubFields = Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text('회원가입'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text('아이디 찾기'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text('비밀 번호 찾기'),
          ),
        )
      ],
    );
    Widget _LoginMainFields = Row(
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
          child: TextButton(onPressed: () {}, child: Text('로그인'),),
        ),
      ],
    );
    Widget _LoginTools = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.black),),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.7,
      child: Column(
        children: [
          _LoginMainFields,
          _LoginSubFields,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login 구현')
        ,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_LoginTools],
        ),
      )
      ,
    );
  }
}
