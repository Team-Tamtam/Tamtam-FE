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
      ),
      home : SmsScreen(),
    );
  }
}


