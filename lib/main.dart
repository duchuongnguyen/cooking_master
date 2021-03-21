import 'package:flutter/material.dart';
import 'file:///D:/MyFlutterApplication/cooking_master/lib/screens/home_screen.dart';
void main() {
  runApp(CookingMasterApp());
}

class CookingMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

