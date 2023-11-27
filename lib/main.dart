import 'package:flutter/material.dart';
import 'screen/selectpage.dart'; // SelectPage를 import합니다.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectPage(), // MyApp의 home을 SelectPage로 설정합니다.
    );
  }
}
