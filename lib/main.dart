import 'package:flutter/material.dart';
import 'screens/sms_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'flutter demo',
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8E52F5), // 모든 AppBar의 배경색 설정
        ),
      ),
      home : SmsScreen(),
    );
  }
}


